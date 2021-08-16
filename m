Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410041.outbound.protection.outlook.com
 ([40.107.141.41] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFSld-00G1cZ-5y
 for kexec@lists.infradead.org; Mon, 16 Aug 2021 02:54:29 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 0/2] makedumpfile: fix two bugs with --dry-run
Date: Mon, 16 Aug 2021 02:54:12 +0000
Message-ID: <TYYPR01MB6777D0C9213101D259F0BB10DDFD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210812133940.5370-1-prudo@redhat.com>
In-Reply-To: <20210812133940.5370-1-prudo@redhat.com>
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
To: Philipp Rudo <prudo@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> Hi,
> 
> While playing with the --dry-run option I noticed two bugs. You can find the
> fixes below.
> 
> Thanks
> Philipp
> 
> Philipp Rudo (2):
>   makedumpfile: Fix bad file descriptor error when using --dry-run
>   makedumpfile: Fix --dry-run for incomplete dumps
> 
>  makedumpfile.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --
> 2.31.1

Thank you for the fixes, applied.
https://github.com/makedumpfile/makedumpfile/compare/efef023...5684d4c

Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
