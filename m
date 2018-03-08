Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1etnRz-0001iV-Ce
 for kexec@lists.infradead.org; Thu, 08 Mar 2018 04:46:46 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH v2 1/3] Add a new helper file 'tools.c' that provides
 some useful APIs
Date: Thu, 8 Mar 2018 04:45:08 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE01181547@BPXM01GP.gisp.nec.co.jp>
References: <1520269976-8850-1-git-send-email-bhsharma@redhat.com>
 <1520269976-8850-2-git-send-email-bhsharma@redhat.com>
 <61D4E5D821F1674CB87C99F080A210BE01180CB3@BPXM01GP.gisp.nec.co.jp>
 <CACi5LpM4gAcBNSN9aTtfDnAzwwrcFptNCsDWKcg75gHBaEW1yg@mail.gmail.com>
In-Reply-To: <CACi5LpM4gAcBNSN9aTtfDnAzwwrcFptNCsDWKcg75gHBaEW1yg@mail.gmail.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>

Hi Bhupesh,


> -----Original Message-----
> From: Bhupesh Sharma [mailto:bhsharma@redhat.com]
> Sent: Tuesday, March 06, 2018 7:17 PM
> To: Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>
> Cc: kexec@lists.infradead.org; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>
> Subject: Re: [PATCH v2 1/3] Add a new helper file 'tools.c' that provides some useful APIs
> 
> Hello Masaki,
> 
> On Tue, Mar 6, 2018 at 3:33 PM, Masaki Tachibana
> <mas-tachibana@vf.jp.nec.com> wrote:
> > Hi bhupesh,
> >
> > Thank you for your V2 patchset.
> >
> > When you have introduced tools.c from crash utility,
> > you have deleted a part of htol()'s error handling
> > that is unnecessary for makedumpfile as follows;
> >
> > htol_error:
> > -       switch (flags & (FAULT_ON_ERROR|RETURN_ON_ERROR))
> > -       {
> > -       case FAULT_ON_ERROR:
> > -               RESTART();
> > -
> > -       case RETURN_ON_ERROR:
> > -               if (errptr)
> > -                       *errptr = TRUE;
> > -               break;
> > -       }
> > -
> >         return BADADDR;
> > }
> >
> > As a result of this, htol() does not refer to 3rd parameter 'errptr'
> > and RETURN_ON_ERROR.
> > I understand that some codes are not used on makedumpfile's tools.c.
> > They may be used in the future.
> 
> Indeed the 3rd parameter in 'htol()' is not currently needed by
> makedumpfile code, but like you mentioned I earlier thought it might
> be required for future compatibility some some future feature
> addition.
> 
> > However I think 'errptr' should be deleted, so I have tried modifying
> > your patches as follows;
> > $ diff "PATCH v2 13 Add a new helper file 'tools
> > .c' that provides some useful APIs.patch.old" "PATCH v2 13 Add a new helper file
> >  'tools.c' that provides some useful APIs.patch"
> > 100c100
> > < +ulong htol(char *s, int flags, int *errptr);
> > ---
> >> +ulong htol(char *s, int flags);
> > 681c681
> > < +htol(char *s, int flags, int *errptr)
> > ---
> >> +htol(char *s, int flags)
> >
> > $ diff "PATCH v2 23 arm64 Add support to read sy
> > mbols like _stext from 'prockallsyms'.patch.old" "PATCH v2 23 arm64 Add support
> > to read symbols like _stext from 'prockallsyms'.patch"
> > 62c62
> > < @@ -177,6 +181,45 @@ get_phys_base_arm64(void)
> > ---
> >> @@ -177,6 +181,44 @@ get_phys_base_arm64(void)
> > 94,95c94
> > < +                     kallsym = htol(kallsyms[0], RETURN_ON_ERROR,
> > < +                                     NULL);
> > ---
> >> +                     kallsym = htol(kallsyms[0], 0);
> >
> > How about this ?
> > If you agree, I'll merge the modified patchset into V1.6.4.
> 
> Yes. This seems fine to me. We can add the 3rd parameter to 'htol'
> later if its needed in future.
> 
> Please feel free to merge the modified patchset into V1.6.4

OK. I will merge the modified patchset into V1.6.4.


Thanks
Tachibana

> 
> Regards,
> Bhupesh
> 
> >
> >> -----Original Message-----
> >> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Bhupesh Sharma
> >> Sent: Tuesday, March 06, 2018 2:13 AM
> >> To: kexec@lists.infradead.org
> >> Cc: bhsharma@redhat.com; bhupesh.linux@gmail.com
> >> Subject: [PATCH v2 1/3] Add a new helper file 'tools.c' that provides some useful APIs
> >>
> >> This patch borrows the 'tools.c' helper file from the crash utility
> >> project and adds it to the makedumpfile source code, to allow
> >> some basic useful APIs to be present which can be invoked from
> >> other source code files.
> >>
> >> 'tools.c' provides some useful APIs like 'htol' (convert
> >> a string to a hexadecimal long value), etc. which can be
> >> invoked by other functions (a functionality that is exposed
> >> by follow-up patches).
> >>
> >> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> >> ---
> >>  Makefile       |   2 +-
> >>  common.h       |   8 +
> >>  makedumpfile.h |  14 ++
> >>  tools.c        | 766 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 789 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools.c
> >>
> >> diff --git a/Makefile b/Makefile
> >> index f4b7c56b6f3d..e870b1362c95 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -46,7 +46,7 @@ CFLAGS_ARCH += -m32
> >>  endif
> >>
> >>  SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
> >> -SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c
> >> +SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c
> >>  OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
> >>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
> >> arch/sparc64.c
> >>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
> >> diff --git a/common.h b/common.h
> >> index 6ad3ca7b952c..6e2f657a79c7 100644
> >> --- a/common.h
> >> +++ b/common.h
> >> @@ -19,6 +19,8 @@
> >>  #define TRUE         (1)
> >>  #define FALSE                (0)
> >>  #define ERROR                (-1)
> >> +#define UNUSED       (-1)
> >> +#define RETURN_ON_ERROR      (0x2)
> >>
> >>  #ifndef LONG_MAX
> >>  #define LONG_MAX     ((long)(~0UL>>1))
> >> @@ -35,12 +37,18 @@
> >>  #define round(x, y)  (((x) / (y)) * (y))
> >>  #define roundup(x, y)        ((((x) + ((y) - 1)) / (y)) * (y))
> >>
> >> +#define NUM_HEX  (0x1)
> >> +#define NUM_DEC  (0x2)
> >> +#define NUM_EXPR (0x4)
> >> +#define NUM_ANY  (NUM_HEX|NUM_DEC|NUM_EXPR)
> >> +
> >>  /*
> >>   * Incorrect address
> >>   */
> >>  #define NOT_MEMMAP_ADDR      (0x0)
> >>  #define NOT_KV_ADDR  (0x0)
> >>  #define NOT_PADDR    (ULONGLONG_MAX)
> >> +#define BADADDR      ((ulong)(-1))
> >>
> >>  #endif  /* COMMON_H */
> >>
> >> diff --git a/makedumpfile.h b/makedumpfile.h
> >> index 01eece231475..0ce75e29fa7f 100644
> >> --- a/makedumpfile.h
> >> +++ b/makedumpfile.h
> >> @@ -237,6 +237,9 @@ isAnon(unsigned long mapping)
> >>  #define MIN_ELF_HEADER_SIZE \
> >>       MAX(MIN_ELF32_HEADER_SIZE, MIN_ELF64_HEADER_SIZE)
> >>  static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
> >> +#define STREQ(A, B) (string_exists((char *)A) &&     \
> >> +                  string_exists((char *)B) &&        \
> >> +     (strcmp((char *)(A), (char *)(B)) == 0))
> >>  #define STRNEQ(A, B)(string_exists((char *)(A)) &&   \
> >>                    string_exists((char *)(B)) &&      \
> >>       (strncmp((char *)(A), (char *)(B), strlen((char *)(B))) == 0))
> >> @@ -2319,4 +2322,15 @@ int prepare_splitblock_table(void);
> >>  int initialize_zlib(z_stream *stream, int level);
> >>  int finalize_zlib(z_stream *stream);
> >>
> >> +int parse_line(char *str, char *argv[]);
> >> +char *shift_string_left(char *s, int cnt);
> >> +char *clean_line(char *line);
> >> +char *strip_linefeeds(char *line);
> >> +char *strip_beginning_whitespace(char *line);
> >> +char *strip_ending_whitespace(char *line);
> >> +ulong htol(char *s, int flags, int *errptr);
> >> +int hexadecimal(char *s, int count);
> >> +int decimal(char *s, int count);
> >> +int file_exists(char *file);
> >> +
> >>  #endif /* MAKEDUMPFILE_H */
> >> diff --git a/tools.c b/tools.c
> >> new file mode 100644
> >> index 000000000000..746ffa104816
> >> --- /dev/null
> >> +++ b/tools.c
> >> @@ -0,0 +1,766 @@
> >> +/* tools.c - Borrowed from crash utility code
> >> + *           (https://github.com/crash-utility/crash)
> >> + *
> >> + * Copyright (C) 1999, 2000, 2001, 2002 Mission Critical Linux, Inc.
> >> + * Copyright (C) 2002-2017 David Anderson
> >> + * Copyright (C) 2002-2018 Red Hat, Inc. All rights reserved.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + */
> >> +
> >> +#include "common.h"
> >> +#include "makedumpfile.h"
> >> +#include <ctype.h>
> >> +
> >> +#define FAULT_ON_ERROR               (0x1)
> >> +#define RETURN_ON_ERROR              (0x2)
> >> +#define QUIET                        (0x4)
> >> +#define HEX_BIAS             (0x8)
> >> +#define LONG_LONG            (0x10)
> >> +#define RETURN_PARTIAL               (0x20)
> >> +#define NO_DEVMEM_SWITCH     (0x40)
> >> +
> >> +#define MAX_HEXADDR_STRLEN   (16)
> >> +
> >> +#define FIRSTCHAR(s)         (s[0])
> >> +
> >> +/*
> >> + * Determine whether a file exists, using the caller's stat structure if
> >> + * one was passed in.
> >> + */
> >> +int
> >> +file_exists(char *file)
> >> +{
> >> +     struct stat sbuf;
> >> +
> >> +     if (stat(file, &sbuf) == 0)
> >> +             return TRUE;
> >> +
> >> +     return FALSE;
> >> +}
> >> +
> >> +/*
> >> + * Parse a line into tokens, populate the passed-in argv[] array, and
> >> + * return the count of arguments found. This function modifies the
> >> + * passed-string by inserting a NULL character at the end of each token.
> >> + * Expressions encompassed by parentheses, and strings encompassed by
> >> + * apostrophes, are collected into single tokens.
> >> + */
> >> +int
> >> +parse_line(char *str, char *argv[])
> >> +{
> >> +     int i, j, k;
> >> +     int string;
> >> +     int expression;
> >> +
> >> +     for (i = 0; i < MAXARGS; i++)
> >> +             argv[i] = NULL;
> >> +
> >> +     clean_line(str);
> >> +
> >> +     if (str == NULL || strlen(str) == 0)
> >> +             return(0);
> >> +
> >> +     i = j = k = 0;
> >> +     string = expression = FALSE;
> >> +
> >> +     /*
> >> +      * Special handling for when the first character is a '"'.
> >> +      */
> >> +     if (str[0] == '"') {
> >> +next:
> >> +             do {
> >> +                     i++;
> >> +             } while ((str[i] != NULLCHAR) && (str[i] != '"'));
> >> +
> >> +             switch (str[i])
> >> +             {
> >> +             case NULLCHAR:
> >> +                     argv[j] = &str[k];
> >> +                     return j+1;
> >> +             case '"':
> >> +                     argv[j++] = &str[k+1];
> >> +                     str[i++] = NULLCHAR;
> >> +                     if (str[i] == '"') {
> >> +                             k = i;
> >> +                             goto next;
> >> +                     }
> >> +                     break;
> >> +             }
> >> +     } else
> >> +             argv[j++] = str;
> >> +
> >> +     while (TRUE) {
> >> +             if (j == MAXARGS)
> >> +                     ERRMSG("too many arguments in string!\n");
> >> +
> >> +             while (str[i] != ' ' && str[i] != '\t' && str[i] != NULLCHAR) {
> >> +                     i++;
> >> +             }
> >> +
> >> +             switch (str[i])
> >> +             {
> >> +             case ' ':
> >> +             case '\t':
> >> +                     str[i++] = NULLCHAR;
> >> +
> >> +                     while (str[i] == ' ' || str[i] == '\t') {
> >> +                             i++;
> >> +                     }
> >> +
> >> +                     if (str[i] == '"') {
> >> +                             str[i] = ' ';
> >> +                             string = TRUE;
> >> +                             i++;
> >> +                     }
> >> +
> >> +                     if (!string && str[i] == '(') {
> >> +                             expression = TRUE;
> >> +                     }
> >> +
> >> +                     if (str[i] != NULLCHAR && str[i] != '\n') {
> >> +                             argv[j++] = &str[i];
> >> +                             if (string) {
> >> +                                     string = FALSE;
> >> +                                     while (str[i] != '"' && str[i] != NULLCHAR)
> >> +                                             i++;
> >> +                                     if (str[i] == '"')
> >> +                                             str[i] = ' ';
> >> +                             }
> >> +                             if (expression) {
> >> +                                     expression = FALSE;
> >> +                                     while (str[i] != ')' && str[i] != NULLCHAR)
> >> +                                             i++;
> >> +                             }
> >> +                             break;
> >> +                     }
> >> +                     /* else fall through */
> >> +             case '\n':
> >> +                     str[i] = NULLCHAR;
> >> +                     /* keep falling... */
> >> +             case NULLCHAR:
> >> +                     argv[j] = NULLCHAR;
> >> +                     return(j);
> >> +             }
> >> +     }
> >> +}
> >> +
> >> +/*
> >> + * Defuse controversy re: extensions to ctype.h
> >> + */
> >> +int
> >> +whitespace(int c)
> >> +{
> >> +     return ((c == ' ') ||(c == '\t'));
> >> +}
> >> +
> >> +int
> >> +ascii(int c)
> >> +{
> >> +     return ((c >= 0) && (c <= 0x7f));
> >> +}
> >> +
> >> +/*
> >> + * Strip line-ending whitespace and linefeeds.
> >> + */
> >> +char *
> >> +strip_line_end(char *line)
> >> +{
> >> +     strip_linefeeds(line);
> >> +     strip_ending_whitespace(line);
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip line-beginning and line-ending whitespace and linefeeds.
> >> + */
> >> +char *
> >> +clean_line(char *line)
> >> +{
> >> +     strip_beginning_whitespace(line);
> >> +     strip_linefeeds(line);
> >> +     strip_ending_whitespace(line);
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip line-ending linefeeds in a string.
> >> + */
> >> +char *
> >> +strip_linefeeds(char *line)
> >> +{
> >> +     char *p;
> >> +
> >> +     if (line == NULL || strlen(line) == 0)
> >> +             return(line);
> >> +
> >> +     p = &LASTCHAR(line);
> >> +
> >> +     while (*p == '\n') {
> >> +             *p = NULLCHAR;
> >> +             if (--p < line)
> >> +                     break;
> >> +     }
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip a specified line-ending character in a string.
> >> + */
> >> +char *
> >> +strip_ending_char(char *line, char c)
> >> +{
> >> +     char *p;
> >> +
> >> +     if (line == NULL || strlen(line) == 0)
> >> +             return(line);
> >> +
> >> +     p = &LASTCHAR(line);
> >> +
> >> +     if (*p == c)
> >> +             *p = NULLCHAR;
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip a specified line-beginning character in a string.
> >> + */
> >> +char *
> >> +strip_beginning_char(char *line, char c)
> >> +{
> >> +     if (line == NULL || strlen(line) == 0)
> >> +             return(line);
> >> +
> >> +     if (FIRSTCHAR(line) == c)
> >> +             shift_string_left(line, 1);
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip line-ending whitespace.
> >> + */
> >> +char *
> >> +strip_ending_whitespace(char *line)
> >> +{
> >> +     char *p;
> >> +
> >> +     if (line == NULL || strlen(line) == 0)
> >> +             return(line);
> >> +
> >> +     p = &LASTCHAR(line);
> >> +
> >> +     while (*p == ' ' || *p == '\t') {
> >> +             *p = NULLCHAR;
> >> +             if (p == line)
> >> +                     break;
> >> +             p--;
> >> +     }
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip line-beginning whitespace.
> >> + */
> >> +char *
> >> +strip_beginning_whitespace(char *line)
> >> +{
> >> +     char buf[BUFSIZE];
> >> +     char *p;
> >> +
> >> +     if (line == NULL || strlen(line) == 0)
> >> +             return(line);
> >> +
> >> +     strcpy(buf, line);
> >> +     p = &buf[0];
> >> +     while (*p == ' ' || *p == '\t')
> >> +             p++;
> >> +     strcpy(line, p);
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * End line at first comma found.
> >> + */
> >> +char *
> >> +strip_comma(char *line)
> >> +{
> >> +     char *p;
> >> +
> >> +     if ((p = strstr(line, ",")))
> >> +             *p = NULLCHAR;
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Strip the 0x from the beginning of a hexadecimal value string.
> >> + */
> >> +char *
> >> +strip_hex(char *line)
> >> +{
> >> +     if (STRNEQ(line, "0x"))
> >> +             shift_string_left(line, 2);
> >> +
> >> +     return(line);
> >> +}
> >> +
> >> +/*
> >> + * Turn a string into upper-case.
> >> + */
> >> +char *
> >> +upper_case(const char *s, char *buf)
> >> +{
> >> +     const char *p1;
> >> +     char *p2;
> >> +
> >> +     p1 = s;
> >> +     p2 = buf;
> >> +
> >> +     while (*p1) {
> >> +             *p2 = toupper(*p1);
> >> +             p1++, p2++;
> >> +     }
> >> +
> >> +     *p2 = NULLCHAR;
> >> +
> >> +     return(buf);
> >> +}
> >> +
> >> +/*
> >> + * Return pointer to first non-space/tab in a string.
> >> + */
> >> +char *
> >> +first_nonspace(char *s)
> >> +{
> >> +     return(s + strspn(s, " \t"));
> >> +}
> >> +
> >> +/*
> >> + * Return pointer to first space/tab in a string. If none are found,
> >> + * return a pointer to the string terminating NULL.
> >> + */
> >> +char *
> >> +first_space(char *s)
> >> +{
> >> +     return(s + strcspn(s, " \t"));
> >> +}
> >> +
> >> +/*
> >> + * Replace the first space/tab found in a string with a NULL character.
> >> + */
> >> +char *
> >> +null_first_space(char *s)
> >> +{
> >> +     char *p1;
> >> +
> >> +     p1 = first_space(s);
> >> +     if (*p1)
> >> +             *p1 = NULLCHAR;
> >> +
> >> +     return s;
> >> +}
> >> +
> >> +/*
> >> + * Replace any instances of the characters in string c that are found in
> >> + * string s with the character passed in r.
> >> + */
> >> +char *
> >> +replace_string(char *s, char *c, char r)
> >> +{
> >> +     int i, j;
> >> +
> >> +     for (i = 0; s[i]; i++) {
> >> +             for (j = 0; c[j]; j++) {
> >> +                     if (s[i] == c[j])
> >> +                             s[i] = r;
> >> +             }
> >> +     }
> >> +
> >> +     return s;
> >> +}
> >> +
> >> +/*
> >> + * Find the rightmost instance of a substring in a string.
> >> + */
> >> +char *
> >> +strstr_rightmost(char *s, char *lookfor)
> >> +{
> >> +     char *next, *last, *p;
> >> +
> >> +     for (p = s, last = NULL; *p; p++) {
> >> +             if (!(next = strstr(p, lookfor)))
> >> +                     break;
> >> +             last = p = next;
> >> +     }
> >> +
> >> +     return last;
> >> +}
> >> +
> >> +/*
> >> + * Shifts the contents of a string to the left by cnt characters,
> >> + * disposing the leftmost characters.
> >> + */
> >> +char *
> >> +shift_string_left(char *s, int cnt)
> >> +{
> >> +     int origlen;
> >> +
> >> +     if (!cnt)
> >> +             return(s);
> >> +
> >> +     origlen = strlen(s);
> >> +     memmove(s, s+cnt, (origlen-cnt));
> >> +     *(s+(origlen-cnt)) = NULLCHAR;
> >> +     return(s);
> >> +}
> >> +
> >> +/*
> >> + * Prints a string verbatim, allowing strings with % signs to be displayed
> >> + * without printf conversions.
> >> + */
> >> +void
> >> +print_verbatim(FILE *filep, char *line)
> >> +{
> >> +     int i;
> >> +
> >> +     for (i = 0; i < strlen(line); i++) {
> >> +             fputc(line[i], filep);
> >> +             fflush(filep);
> >> +     }
> >> +}
> >> +
> >> +char *
> >> +fixup_percent(char *s)
> >> +{
> >> +     char *p1;
> >> +
> >> +     if ((p1 = strstr(s, "%")) == NULL)
> >> +             return s;
> >> +
> >> +     s[strlen(s)+1] = NULLCHAR;
> >> +     memmove(p1+1, p1, strlen(p1));
> >> +     *p1 = '%';
> >> +
> >> +     return s;
> >> +}
> >> +
> >> +/*
> >> + * Append a two-character string to a number to make 1, 2, 3 and 4 into
> >> + * 1st, 2nd, 3rd, 4th, and so on...
> >> + */
> >> +char *
> >> +ordinal(ulong val, char *buf)
> >> +{
> >> +     char *p1;
> >> +
> >> +     sprintf(buf, "%ld", val);
> >> +     p1 = &buf[strlen(buf)-1];
> >> +
> >> +     switch (*p1)
> >> +     {
> >> +     case '1':
> >> +             strcat(buf, "st");
> >> +             break;
> >> +     case '2':
> >> +             strcat(buf, "nd");
> >> +             break;
> >> +     case '3':
> >> +             strcat(buf, "rd");
> >> +             break;
> >> +     default:
> >> +             strcat(buf, "th");
> >> +             break;
> >> +     }
> >> +
> >> +     return buf;
> >> +}
> >> +
> >> +/*
> >> + * Determine whether a string contains only decimal characters.
> >> + * If count is non-zero, limit the search to count characters.
> >> + */
> >> +int
> >> +decimal(char *s, int count)
> >> +{
> >> +     char *p;
> >> +     int cnt, digits;
> >> +
> >> +     if (!count) {
> >> +             strip_line_end(s);
> >> +             cnt = 0;
> >> +     } else
> >> +             cnt = count;
> >> +
> >> +     for (p = &s[0], digits = 0; *p; p++) {
> >> +             switch(*p)
> >> +             {
> >> +             case '0':
> >> +             case '1':
> >> +             case '2':
> >> +             case '3':
> >> +             case '4':
> >> +             case '5':
> >> +             case '6':
> >> +             case '7':
> >> +             case '8':
> >> +             case '9':
> >> +                     digits++;
> >> +             case ' ':
> >> +                     break;
> >> +             default:
> >> +                     return FALSE;
> >> +             }
> >> +
> >> +             if (count && (--cnt == 0))
> >> +                     break;
> >> +     }
> >> +
> >> +     return (digits ? TRUE : FALSE);
> >> +}
> >> +
> >> +/*
> >> + * Determine whether a string contains only ASCII characters.
> >> + */
> >> +int
> >> +ascii_string(char *s)
> >> +{
> >> +     char *p;
> >> +
> >> +     for (p = &s[0]; *p; p++) {
> >> +             if (!ascii(*p))
> >> +                     return FALSE;
> >> +     }
> >> +
> >> +     return TRUE;
> >> +}
> >> +
> >> +/*
> >> + * Check whether a string contains only printable ASCII characters.
> >> + */
> >> +int
> >> +printable_string(char *s)
> >> +{
> >> +     char *p;
> >> +
> >> +     for (p = &s[0]; *p; p++) {
> >> +             if (!isprint(*p))
> >> +                     return FALSE;
> >> +     }
> >> +
> >> +     return TRUE;
> >> +}
> >> +
> >> +/*
> >> + * Convert a string to a hexadecimal long value.
> >> + */
> >> +ulong
> >> +htol(char *s, int flags, int *errptr)
> >> +{
> >> +     ulong i, j;
> >> +     ulong n;
> >> +
> >> +     if (s == NULL) {
> >> +             if (!(flags & QUIET))
> >> +                     ERRMSG("received NULL string\n");
> >> +             goto htol_error;
> >> +     }
> >> +
> >> +     if (STRNEQ(s, "0x") || STRNEQ(s, "0X"))
> >> +             s += 2;
> >> +
> >> +     if (strlen(s) > MAX_HEXADDR_STRLEN) {
> >> +             if (!(flags & QUIET))
> >> +                     ERRMSG("input string too large: \"%s\" (%d vs %d)\n",
> >> +                                     s, (int)strlen(s), (int)MAX_HEXADDR_STRLEN);
> >> +             goto htol_error;
> >> +     }
> >> +
> >> +     for (n = i = 0; s[i] != 0; i++) {
> >> +             switch (s[i])
> >> +             {
> >> +             case 'a':
> >> +             case 'b':
> >> +             case 'c':
> >> +             case 'd':
> >> +             case 'e':
> >> +             case 'f':
> >> +                     j = (s[i] - 'a') + 10;
> >> +                     break;
> >> +             case 'A':
> >> +             case 'B':
> >> +             case 'C':
> >> +             case 'D':
> >> +             case 'E':
> >> +             case 'F':
> >> +                     j = (s[i] - 'A') + 10;
> >> +                     break;
> >> +             case '1':
> >> +             case '2':
> >> +             case '3':
> >> +             case '4':
> >> +             case '5':
> >> +             case '6':
> >> +             case '7':
> >> +             case '8':
> >> +             case '9':
> >> +             case '0':
> >> +                     j = s[i] - '0';
> >> +                     break;
> >> +             case 'x':
> >> +             case 'X':
> >> +             case 'h':
> >> +                     continue;
> >> +             default:
> >> +                     if (!(flags & QUIET))
> >> +                             ERRMSG("invalid input: \"%s\"\n", s);
> >> +                     goto htol_error;
> >> +             }
> >> +             n = (16 * n) + j;
> >> +     }
> >> +
> >> +     return(n);
> >> +
> >> +htol_error:
> >> +     return BADADDR;
> >> +}
> >> +
> >> +/*
> >> + * Determine whether a string contains only hexadecimal characters.
> >> + * If count is non-zero, limit the search to count characters.
> >> + */
> >> +int
> >> +hexadecimal(char *s, int count)
> >> +{
> >> +     char *p;
> >> +     int cnt, digits;
> >> +
> >> +     if (!count) {
> >> +             strip_line_end(s);
> >> +             cnt = 0;
> >> +     } else
> >> +             cnt = count;
> >> +
> >> +     for (p = &s[0], digits = 0; *p; p++) {
> >> +             switch(*p)
> >> +             {
> >> +             case 'a':
> >> +             case 'b':
> >> +             case 'c':
> >> +             case 'd':
> >> +             case 'e':
> >> +             case 'f':
> >> +             case 'A':
> >> +             case 'B':
> >> +             case 'C':
> >> +             case 'D':
> >> +             case 'E':
> >> +             case 'F':
> >> +             case '1':
> >> +             case '2':
> >> +             case '3':
> >> +             case '4':
> >> +             case '5':
> >> +             case '6':
> >> +             case '7':
> >> +             case '8':
> >> +             case '9':
> >> +             case '0':
> >> +                     digits++;
> >> +             case 'x':
> >> +             case 'X':
> >> +                     break;
> >> +
> >> +             case ' ':
> >> +                     if (*(p+1) == NULLCHAR)
> >> +                             break;
> >> +                     else
> >> +                             return FALSE;
> >> +             default:
> >> +                     return FALSE;
> >> +             }
> >> +
> >> +             if (count && (--cnt == 0))
> >> +                     break;
> >> +     }
> >> +
> >> +     return (digits ? TRUE : FALSE);
> >> +}
> >> +
> >> +/*
> >> + * Determine whether a string contains only hexadecimal characters.
> >> + * and cannot be construed as a decimal number.
> >> + * If count is non-zero, limit the search to count characters.
> >> + */
> >> +int
> >> +hexadecimal_only(char *s, int count)
> >> +{
> >> +     char *p;
> >> +     int cnt, only;
> >> +
> >> +     if (!count) {
> >> +             strip_line_end(s);
> >> +             cnt = 0;
> >> +     } else
> >> +             cnt = count;
> >> +
> >> +     only = 0;
> >> +
> >> +     for (p = &s[0]; *p; p++) {
> >> +             switch(*p)
> >> +             {
> >> +             case 'a':
> >> +             case 'b':
> >> +             case 'c':
> >> +             case 'd':
> >> +             case 'e':
> >> +             case 'f':
> >> +             case 'A':
> >> +             case 'B':
> >> +             case 'C':
> >> +             case 'D':
> >> +             case 'E':
> >> +             case 'F':
> >> +             case 'x':
> >> +             case 'X':
> >> +                     only++;
> >> +                     break;
> >> +             case '1':
> >> +             case '2':
> >> +             case '3':
> >> +             case '4':
> >> +             case '5':
> >> +             case '6':
> >> +             case '7':
> >> +             case '8':
> >> +             case '9':
> >> +             case '0':
> >> +                     break;
> >> +
> >> +             case ' ':
> >> +                     if (*(p+1) == NULLCHAR)
> >> +                             break;
> >> +                     else
> >> +                             return FALSE;
> >> +             default:
> >> +                     return FALSE;
> >> +             }
> >> +
> >> +             if (count && (--cnt == 0))
> >> +                     break;
> >> +     }
> >> +
> >> +     return only;
> >> +}
> >> --
> >> 2.7.4
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
