Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bN7NF-0006qH-NS
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 23:45:59 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CNcw25147385
 for <kexec@lists.infradead.org>; Tue, 12 Jul 2016 19:45:37 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452xr64g6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 12 Jul 2016 19:45:36 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 19:45:35 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160712140242.GA30181@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <2675986.6AfrV5PCe0@hactar>
 <20160712140242.GA30181@redhat.com>
Date: Wed, 13 Jul 2016 09:45:22 +1000
MIME-Version: 1.0
Message-Id: <877fcqpgj1.fsf@linux.vnet.ibm.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Vivek Goyal <vgoyal@redhat.com> writes:
> On Tue, Jul 12, 2016 at 10:58:09AM -0300, Thiago Jung Bauermann wrote:
>> Hello Eric,
>> 
>> Am Dienstag, 12 Juli 2016, 08:25:48 schrieb Eric W. Biederman:
>> > AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
>> > > Device tree blob must be passed to a second kernel on DTB-capable
>> > > archs, like powerpc and arm64, but the current kernel interface
>> > > lacks this support.
>> > > 
>> > > This patch extends kexec_file_load system call by adding an extra
>> > > argument to this syscall so that an arbitrary number of file descriptors
>> > > can be handed out from user space to the kernel.
>> > > 
>> > > See the background [1].
>> > > 
>> > > Please note that the new interface looks quite similar to the current
>> > > system call, but that it won't always mean that it provides the "binary
>> > > compatibility."
>> > > 
>> > > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
>> > 
>> > So this design is wrong.  The kernel already has the device tree blob,
>> > you should not be extracting it from the kernel munging it, and then
>> > reinserting it in the kernel if you want signatures and everything to
>> > pass.
>> > 
>> > What x86 does is pass it's equivalent of the device tree blob from one
>> > kernel to another directly and behind the scenes.  It does not go
>> > through userspace for this.
>> > 
>> > Until a persuasive case can be made for going around the kernel and
>> > probably adding a feature (like code execution) that can be used to
>> > defeat the signature scheme I am going to nack this.
>> 
>> There are situations where userspace needs to change things in the device 
>> tree to be used by the next kernel.
>> 
>> For example, Petitboot (the boot loader used in OpenPOWER machines) is a 
>> userspace application running in an intermediary Linux instance and uses 
>> kexec to load the target OS. It has to modify the device tree that will be 
>> used by the next kernel so that the next kernel uses the same console that 
>> petitboot was configured to use (i.e., set the /chosen/linux,stdout-path 
>> property). It also modifies the device tree to allow the kernel to inherit 
>> Petitboot's Openfirmware framebuffer.
>
> Can some of this be done with the help of kernel command line options for
> second kernel?

how would this be any more secure?

Passing in an address for a framebuffer via command line option means
you could scribble over any bit of memory, which is the same kind of
damage you could do by modifying the device tree.

-- 
Stewart Smith
OPAL Architect, IBM.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
