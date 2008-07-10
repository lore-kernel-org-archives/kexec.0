Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KGkmG-0008L9-BH
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 01:16:57 +0000
Message-Id: <487562F0.8020606@mxs.nes.nec.co.jp>
Date: Thu, 10 Jul 2008 10:16:32 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Improve error handing when SIZE(nodemask_t)
	is undefined
References: <20080709134801.149fbdb4@halley.suse.de>
In-Reply-To: <20080709134801.149fbdb4@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1771672492=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============1771672492==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> I accidentally used a new makedumpfile with an old VMCOREINFO that did
> not contain the SIZE(nodemask_t). Then len was -1, and malloc(-1)
> failed. Which looked like memory was too low.
> 
> This patch just improves the error message in that case so that the
> user knows what is wrong.

Thank you for the patch.
I agree to add this check method.


> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  makedumpfile.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff -u -r1.7.2.37 makedumpfile.c
> --- makedumpfile.c	9 Jul 2008 00:22:09 -0000	1.7.2.37
> +++ makedumpfile.c	9 Jul 2008 11:39:43 -0000
> @@ -2580,6 +2580,11 @@
>  	    && (SYMBOL(node_states) == NOT_FOUND_SYMBOL))
>  		return 0;
> 
> +	if (SIZE(nodemask_t) == NOT_FOUND_LONG_VALUE) {
> +		ERRMSG("SIZE(nodemask_t) undefined.\n");

I like the following message of the same form as another message.

ERRMSG("Can't get the size of nodemask_t.\n");


Thanks
Ken'ichi Ohmichi


--===============1771672492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1771672492==--
