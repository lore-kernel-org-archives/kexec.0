Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pfepa.post.tele.dk ([195.41.46.235])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2Kjm-0001uX-BP
	for kexec@lists.infradead.org; Fri, 08 May 2009 07:43:26 +0000
Date: Fri, 8 May 2009 09:45:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 07/14] x86,
	boot: simplify arch/x86/boot/compressed/Makefile
Message-ID: <20090508074527.GE12808@uranus.ravnborg.org>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-8-git-send-email-hpa@linux.intel.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1241735222-6640-8-git-send-email-hpa@linux.intel.com>
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
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

On Thu, May 07, 2009 at 03:26:55PM -0700, H. Peter Anvin wrote:
> From: H. Peter Anvin <hpa@zytor.com>
> 
> Simplify the arch/x86/boot/compressed/Makefile, by using the new
> capability of specifying multiple inputs to a compressor, and the
> CONFIG_X86_NEED_RELOCS Kconfig symbol.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Very nice cleanup!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
