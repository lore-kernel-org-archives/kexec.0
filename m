Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pfepb.post.tele.dk ([195.41.46.236])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2Xgj-0000Ny-6n
	for kexec@lists.infradead.org; Fri, 08 May 2009 21:33:07 +0000
Date: Fri, 8 May 2009 23:35:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 09/14] x86,
	boot: add new runtime_address and runtime_size bzImage fields
Message-ID: <20090508213510.GB18712@uranus.ravnborg.org>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-10-git-send-email-hpa@linux.intel.com>
	<20090508075516.GF12808@uranus.ravnborg.org>
	<4A049F80.2090400@zytor.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A049F80.2090400@zytor.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, tglx@linutronix.de, vgoyal@redhat.com

On Fri, May 08, 2009 at 02:09:20PM -0700, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> >> 	@:
> >>@@ -50,6 +53,9 @@ suffix_$(CONFIG_KERNEL_GZIP)  = gz
> >> suffix_$(CONFIG_KERNEL_BZIP2) = bz2
> >> suffix_$(CONFIG_KERNEL_LZMA)  = lzma
> >
> >No need for a recursive assignment here. Use ":="
> >Ann we usually uses "-y" not "_y".
> >
> 
> Wasn't part of the patch, but OK :)

I overlooked that fact - I often just review what I can see.
(In other words - I should have caught that detail when the original
patch was posted...)

	Sam

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
