Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bLX5g-0001SS-6A
 for kexec@lists.infradead.org; Fri, 08 Jul 2016 14:49:21 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u68Ei4q7114724
 for <kexec@lists.infradead.org>; Fri, 8 Jul 2016 10:48:54 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xnrt64-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 08 Jul 2016 10:48:54 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 11:48:51 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC] arm64: kexec_file_load support
Date: Fri, 08 Jul 2016 11:48:44 -0300
In-Reply-To: <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <11139482.zLvCKVycQr@hactar>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, kexec@lists.infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, catalin.marinas@arm.com, linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com

Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> If so maybe change a bit from your precious mentioned 7 args proposal like
> below?
> 
> struct kexec_file_fd {
> 	enum kexec_file_type;
> 	int fd;
> }
> 
> struct kexec_fdset {
> 	int nr_fd;
> 	struct kexec_file_fd fd[0];
> }
> 
> int kexec_file_load(int kernel_fd, int initrd_fd,
> 		    unsigned long cmdline_len, const char *cmdline_ptr,
> 		    unsigned long flags, struct kexec_fdset *extra_fds);


Is there a way for the kernel to distinguish whether the process passed 5 or 
6 arguments? How can it know whether extra_fds is a valid argument or just 
garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
the process can signal that it is using the new interface.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
