Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e3zVt-0002cT-4L
 for kexec@lists.infradead.org; Mon, 16 Oct 2017 07:08:52 +0000
Date: Mon, 16 Oct 2017 09:02:05 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] kexec-tools: mips: Try to include bss in kernel
 vmcore file.
Message-ID: <20171016070205.qaghovtwnfhy2u2n@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-5-david.daney@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-5-david.daney@cavium.com>
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
To: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org

On Thu, Oct 12, 2017 at 02:02:28PM -0700, David Daney wrote:
> The kernel message buffers, as well as a lot of other useful data
> reside in the bss section.  Without this vmcore-dmesg cannot work, and
> debugging with a core dump is much more difficult.
> 
> Try to add the /proc/iomem "Kernel bss" section to vmcore.  If it is
> not found, just do what we used to do and use "Kernel data" instead.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
