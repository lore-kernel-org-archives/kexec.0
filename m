Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]
	helo=rgminet11.oracle.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMW13-0005MR-3f
	for kexec@lists.infradead.org; Mon, 12 Jan 2009 23:16:19 +0000
Message-ID: <496BCF2F.1060700@oracle.com>
Date: Mon, 12 Jan 2009 15:15:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
Subject: Re: newbie question: kexec linux-based bootstrap
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>	<496B4127.1070201@anduras.de>
	<F795765B112E7344AF36AA911279641508F6B39B@xmb-sjc-212.amer.cisco.com>
	<496BBE57.2040802@oracle.com>
	<F795765B112E7344AF36AA911279641508F6B3F5@xmb-sjc-212.amer.cisco.com>
	<496BCA08.4000901@oracle.com>
	<F795765B112E7344AF36AA911279641508F6B42E@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641508F6B42E@xmb-sjc-212.amer.cisco.com>
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
>> You enabled kexec in the new kernel that you are trying to load or in
>> the first/running kernel?  It appears that kexec is not loaded in the
>> first/running kernel, but it must be enabled for kexec-tools to work
>> correctly.
> 
> Yes, that was the problem, now I am getting a new error, I do not care
> for crash dump, but when I execute kexec -e it ask me to reserve some
> space for it and use kdump kernel, which is not the case I am
> interested:
> 
> # ./kexec -e -append="root/dev/sdb2"
> Memory for crashkernel is not reserved
> Please reserve memory by passing "crashkernel=X@Y" parameter to the
> kernel
> Then try loading kdump kernel
> 
> 
> ???

You still need to reserve space for the new kernel to be loaded into.
It has to be loaded into memory before it is needed.

Those messages that say "crashkernel" can be misleading, but that's
what the kernel parameter is named.

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
