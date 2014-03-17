Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WPSjX-0002pK-Pw
 for kexec@lists.infradead.org; Mon, 17 Mar 2014 08:17:21 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 0/3] makedumpfile: Bunch of fixes for --dump-dmesg
Date: Mon, 17 Mar 2014 08:15:34 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F6F31@BPXM01GP.gisp.nec.co.jp>
References: <cover.1394805652.git.petr@tesarici.cz>
In-Reply-To: <cover.1394805652.git.petr@tesarici.cz>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

>This patch series addresses several issues with the dump_log_entry()
>function.
>
>Petr Tesarik (3):
>  Fix string append in dump_log_entry()
>  Prevent buffer overflow in dump_log_entry
>  Optimize one-character output in dump_log_entry
>
> makedumpfile.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)

Looks good to me, I really appreciate your help !

Acked-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
