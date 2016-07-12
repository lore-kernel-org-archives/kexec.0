Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMyCt-0003CI-U1
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 13:58:43 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CDv7SA107613
 for <kexec@lists.infradead.org>; Tue, 12 Jul 2016 09:58:17 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24507av7tm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 12 Jul 2016 09:58:17 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 10:58:14 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Tue, 12 Jul 2016 10:58:09 -0300
In-Reply-To: <87furf7ztv.fsf@x220.int.ebiederm.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-Id: <2675986.6AfrV5PCe0@hactar>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, dyoung@redhat.com, vgoyal@redhat.com

Hello Eric,

Am Dienstag, 12 Juli 2016, 08:25:48 schrieb Eric W. Biederman:
> AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
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
> So this design is wrong.  The kernel already has the device tree blob,
> you should not be extracting it from the kernel munging it, and then
> reinserting it in the kernel if you want signatures and everything to
> pass.
> 
> What x86 does is pass it's equivalent of the device tree blob from one
> kernel to another directly and behind the scenes.  It does not go
> through userspace for this.
> 
> Until a persuasive case can be made for going around the kernel and
> probably adding a feature (like code execution) that can be used to
> defeat the signature scheme I am going to nack this.

There are situations where userspace needs to change things in the device 
tree to be used by the next kernel.

For example, Petitboot (the boot loader used in OpenPOWER machines) is a 
userspace application running in an intermediary Linux instance and uses 
kexec to load the target OS. It has to modify the device tree that will be 
used by the next kernel so that the next kernel uses the same console that 
petitboot was configured to use (i.e., set the /chosen/linux,stdout-path 
property). It also modifies the device tree to allow the kernel to inherit 
Petitboot's Openfirmware framebuffer.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
