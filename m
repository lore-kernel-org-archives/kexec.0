Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bJ0ek-0007ve-1n
 for kexec@lists.infradead.org; Fri, 01 Jul 2016 15:47:02 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61Fhbjf117366
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 11:46:40 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wbbbwvrk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 01 Jul 2016 11:46:39 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 12:46:38 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC] arm64: kexec_file_load support
Date: Fri, 01 Jul 2016 12:46:31 -0300
In-Reply-To: <20160701051111.GL20774@linaro.org>
References: <20160701051111.GL20774@linaro.org>
MIME-Version: 1.0
Message-Id: <3300473.zhbeG65qgA@hactar>
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
To: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, catalin.marinas@arm.com, linuxppc-dev@lists.ozlabs.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

Am Freitag, 01 Juli 2016, 14:11:12 schrieb AKASHI Takahiro:
> I'm not sure whether there is any demand for kexec_file_load
> support on arm64, but anyhow I'm working on this and now
> my early prototype code does work fine.

It is necessary if you want to support loading only signed kernels, and also 
if you want IMA to measure the kernel in its event log.

> There is, however, one essential issue:
> While arm64 kernel requires a device tree blob to be set up
> correctly at boot time, the current system call API doesn't
> have this parameter.
>     int kexec_file_load(int kernel_fd, int initrd_fd,
>                         unsigned long cmdline_len, const char
> *cmdline_ptr, unsigned long flags);
> 
> Should we invent a new system call, like kexec_file_load2,
> and, if so, what kind of interface would be desired?

I'm facing the same issue on powerpc. What I'm doing is taking the device 
tree that was used to boot the current kernel and modifying it as necessary 
to pass it to the next kernel.

I agree that it would be better if we could have a system call where a 
custom device tree could be passed. One suggestion is:


kexec_file_load2(int fds[], int fd_types[], int nr_fds,
		 unsigned long cmdline_len, const char *cmdline_ptr,
		unsigned long flags);

Where fds is an array with nr_fds file descriptors and fd_types is an array 
specifying what each fd in fds is. So for example, if fds[i] is the kernel, 
then fd_types[i] would have the value KEXEC_FILE_KERNEL_FD. If fds[i] is the 
device tree blob, fd_types[i], would have the value KEXEC_FILE_DTB and so 
on. That way, the syscall can be extended for an arbitrary number and types 
of segments that have to be loaded, just like kexec_load.

Another option is to have a struct:

kexec_file_load2(struct kexec_file_params *params, unsigned long params_sz);

Where:

struct kexec_file_params {
	int version;	/* allows struct to be extended in the future */
	int fds[];
	int fd_types[];
	int nr_fds;
	unsigned long cmdline_len;
	const char *cmdline_ptr;
	unsigned long flags;
};

This is even more flexible.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
