Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]
	helo=rgminet12.oracle.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMVhc-0008JQ-NS
	for kexec@lists.infradead.org; Mon, 12 Jan 2009 22:56:15 +0000
Message-ID: <496BCA08.4000901@oracle.com>
Date: Mon, 12 Jan 2009 14:54:00 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
Subject: Re: newbie question: kexec linux-based bootstrap
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>	<496B4127.1070201@anduras.de>
	<F795765B112E7344AF36AA911279641508F6B39B@xmb-sjc-212.amer.cisco.com>
	<496BBE57.2040802@oracle.com>
	<F795765B112E7344AF36AA911279641508F6B3F5@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641508F6B3F5@xmb-sjc-212.amer.cisco.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Cc: Sven Anders <anders@anduras.de>, kexec@lists.infradead.org

Bizhan Gholikhamseh (bgholikh) wrote:
> 
>> I use kexec daily for boot-testing new kernels.
> I have enabled the kexec in the kernel configuration, when I ran the
> kexec I get the following error:

You enabled kexec in the new kernel that you are trying to load or in
the first/running kernel?  It appears that kexec is not loaded in the
first/running kernel, but it must be enabled for kexec-tools to work
correctly.


> # ./kexec -l ./bzImage
> kexec_load failed: Function not implemented
> entry       = 0x977b8 flags = 0
> nr_segments = 3
> segment[0].buf   = 0x8071600
> segment[0].bufsz = 2a00
> segment[0].mem   = 0x3000
> segment[0].memsz = 3000
> segment[1].buf   = 0x806a550
> segment[1].bufsz = 7060
> segment[1].mem   = 0x97000
> segment[1].memsz = 9000
> segment[2].buf   = 0xb7c3aa08
> segment[2].bufsz = 1d7eb8
> segment[2].mem   = 0x100000
> segment[2].memsz = 1d8000
> 
> ???                             
> 


-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
