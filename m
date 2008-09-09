Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kczsw-0003GS-Us
	for kexec@lists.infradead.org; Tue, 09 Sep 2008 09:51:47 +0000
Message-ID: <48C63F6C.3040005@mxs.nes.nec.co.jp>
Date: Tue, 09 Sep 2008 18:18:36 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Use gzip for manpage compression
References: <e31c137cf40f10b0a445.1220949784@kepler.site>
In-Reply-To: <e31c137cf40f10b0a445.1220949784@kepler.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1454758629=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============1454758629==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> Use gzip instead of zip for manual page compression. That's the usual
> method of compressing manual pages on Unix.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thank you for the patch.
After applying your patch, the file size of manpage is reduced.
(3774bytes -> 3647bytes).
The patch will be applied to the next release.


Thanks
Ken'ichi Ohmichi


--===============1454758629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1454758629==--
