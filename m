Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1besPV-0000IY-8q
 for kexec@lists.infradead.org; Tue, 30 Aug 2016 23:25:42 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UNNOhG111491
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 19:25:20 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2558r5u4c4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 19:25:20 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 30 Aug 2016 20:25:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] extend kexec_file_load system call
Date: Tue, 30 Aug 2016 20:25:08 -0300
In-Reply-To: <20160818102112.GB27045@leverpostej>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160818102112.GB27045@leverpostej>
MIME-Version: 1.0
Message-Id: <2408856.dZN5fLyePL@hactar>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, David Laight <David.Laight@aculab.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello Mark,

Sorry for taking this long to respond. I've been focusing on getting my 
kexec_file_load and kexec buffer hand-over series in shape.

Am Donnerstag, 18 August 2016, 11:21:13 schrieb Mark Rutland:
> On Thu, Aug 11, 2016 at 08:03:56PM -0300, Thiago Jung Bauermann wrote:
> > Device tree blob must be passed to a second kernel on DTB-capable
> > archs, like powerpc and arm64, but the current kernel interface
> > lacks this support.
> > 
> > This patch extends kexec_file_load system call by adding an extra
> > argument to this syscall so that an arbitrary number of file descriptors
> > can be handed out from user space to the kernel.
> > 
> > See the background [1].
> > 
> > Please note that the new interface looks quite similar to the current
> > system call, but that it won't always mean that it provides the "binary
> > compatibility."
> > 
> > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> 
> As with the original posting, I have a number of concerns, and I'm
> really not keen on this.

Thanks for laying out out the reasons for your objection. That's very 
helpful.

> * For typical usecases, I do not believe that this is necessary (at
>   least for arm64), and generally do not believe that it should be
>   necessary for a user to manipulate the DTB (much like the user need
>   not manipulate ACPI tables or other FW data structures).
> 
>   Other than (potentially) the case of Linux as a flashed-in bootloader,
>   I don't see a compelling case for modifying the DTB that could not be
>   accomplished in-kernel. For that case, if truly necessary, I think
>   that we can get away with something simpler.

Yes, this is the case I am aiming for. I'll experiment with a couple of 
different approaches and see how well they perform.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
