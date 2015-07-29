<!--
    Civic engagement in Europe explorer - R Shiny application
    Copyright (C) 2015  Mirosław Zalewski <mz@miroslaw-zalewski.eu>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->

# Data and methodology

European Social Survey questionnaire includes following table:

|   | Have you…                                                         | Yes | No  | (Don't know) |
|:--|:------------------------------------------------------------------|:---:|:---:|:------------:|
|B11| …contacted a politician, government or local government official? |  1  |  2  |     8        |
|B12| …worked in a political party or action group?                     |  1  |  2  |     8        |
|B13| …worked in another organisation or association?                   |  1  |  2  |     8        |
|B14| …worn or displayed a campaign badge/sticker?                      |  1  |  2  |     8        |
|B15| …signed a petition?                                               |  1  |  2  |     8        |
|B16| …taken part in a lawful public demonstration?                     |  1  |  2  |     8        |
|B17| …boycotted certain products?                                      |  1  |  2  |     8        |

Source: European Social Survey, (2012). *ESS Round 6 Source Questionnaire*. London: Centre for Comparative Social Surveys, City University London.

These questions refers to activities that can be collectively called "[civic engagement](https://en.wikipedia.org/wiki/Civic_engagement)".

We believe that the most accurate overview of society state can be obtained from analysing all these questions at once. For this purpose we introduce civic engagement index.

Civic engagement index is simple synthetic indicator that reduces seven answers to individual questions to one point at eight-point scale. It is produced by counting number of affirmative answers in aforementioned table for each respondent. Person who received seven points can be considered fully engaged in civic matters. Person who received 0 points can be considered to be not engaged at all. Other people are somewhat, more or less, engaged.

Depending on local context, some questions could be more important than others. Nevertheless, in this study we treat all of them equally. Being part of public demonstration does not load index in greater extent than wearing a badge, even if the first activity is more demanding than the second.

Higher values are generally more desirable, as they show that people feel they can influence social environment they live in. That feeling is the first step on the road to actual change.

Source of data: European Social Survey Cumulative File, ESS 1-5 (2012). Data file edition 1.0. Norwegian Social Science Data Services, Norway - Data Archive and distributor of ESS data. 

# About

Created by [Mirosław Zalewski](http://FIXME.invalid).

Licensed under GNU AGPL 3.0 or later (see COPYING file for details).

Code can be found on [github](https://github.com/mirzal/ESS-civic-engagement) and [bitbucket](https://bitbucket.org/mirzal/ess-civic-engagement).
