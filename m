Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-tycjpn01on20622.outbound.protection.outlook.com
 ([2a01:111:f403:7010::622]
 helo=JPN01-TYC-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxIdS-00GEYS-No
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 00:59:12 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [RFC PATCH] makedumpfile: add userinfo elf section 0/4]
Date: Wed, 15 Dec 2021 00:58:55 +0000
Message-ID: <TYYPR01MB6777405BB7E0B8F2F0220FB6DD769@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20211201134730.15943-1-ikhoronz@cisco.com>
In-Reply-To: <20211201134730.15943-1-ikhoronz@cisco.com>
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
To: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Ivan Khoronzhuk <ikhoronz@cisco.com>

Hi Ivan,

sorry for the delay.

-----Original Message-----
> These patchset suggests feature to add user specific information along
> with dumpfile. One of usecases could be a platform build information
> containing dubug file addresses, sources of daily build, some
> platform related information and more, it's gracefully simplifies
> debugging process, since an engineer doesn't need to spend time on
> finding to which platform this core file is related, where to get
> debugging counter part and so on. As user info can be added along with
> dumpfile it frees platform from creating tar achieve spending doubled
> space or using specific tools.

Hmm, currently I don't think it will be worth making makedumpfile have
the memo-like feature even with accepting some code and complexity.
If makedumpfile can access that helpful data in 2nd kernel, kdump tool
will be able to place it next to the dumpfile.  There will become two
files to be handled, but I'm not sure what the problem is with it..

Thanks,
Kazu

> Since this information is sorted and
> selected by user it can't be standardized and should be placed in some
> special generic section. This patchset roughly proposes the variant when
> user information is placed/retrieved as subsection of note elf
> section.
> 
> Ivan Khoronzhuk (4):
>   makedumpfile: rename check_dump_file() on check_file_is_writable()
>   elf: add new "userinfo" ELF section to traverse debug information
>   elf_info: make int note_descsz() and offset_next_note() public
>   elf: add ability to read the userinfo data from note segment
> 
>  elf_info.c     |   4 +-
>  elf_info.h     |   5 +
>  makedumpfile.c | 393 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  makedumpfile.h |  12 ++
>  4 files changed, 404 insertions(+), 10 deletions(-)
> 
> --
> 2.20.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
