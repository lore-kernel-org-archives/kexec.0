Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PrkJx-0006xP-4Z
	for kexec@lists.infradead.org; Tue, 22 Feb 2011 04:57:58 +0000
Date: Tue, 22 Feb 2011 13:56:01 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile's segmentation fault with option -V
Message-Id: <20110222135601.19799711.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110222.123458.104045336.d.hatayama@jp.fujitsu.com>
References: <20110222.123458.104045336.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org


Hi,

On Tue, 22 Feb 2011 12:34:58 +0900 (   )
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> On fc14 and el6 on x86_64, makedumpfile has resulted in segmentation
> fault with option -V.
> 
>   $ makedumpfile -V
>   Segmentation fault (core dumped)
> 
> I've found this by mistaking -v for -V to display version information.

Thank you for the report.
That is a bug, and it will be fixed.

-V option is not public, and it is used internally for --vtop option.
A bug is that the second argument in getopt_long() includes 'V'.
This patch fixes it.


Thanks
Ken'ichi Ohmichi

diff --git a/makedumpfile.c b/makedumpfile.c
index 80f6b70..8847668 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7844,7 +7844,7 @@ main(int argc, char *argv[])

        info->block_order = DEFAULT_ORDER;
        message_level = DEFAULT_MSG_LEVEL;
-       while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:MRrsVvXx:", longopts,
+       while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:MRrsvXx:", longopts,
            NULL)) != -1) {
                switch (opt) {
                case 'b':
---

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
