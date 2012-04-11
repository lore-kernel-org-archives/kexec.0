Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHtE5-0006bu-8f
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 08:48:30 +0000
Message-ID: <4F85454E.6020201@redhat.com>
Date: Wed, 11 Apr 2012 11:48:14 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] KVM: VMX: Add functions to fill VMCSINFO
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F84E365.10201@cn.fujitsu.com>
In-Reply-To: <4F84E365.10201@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

On 04/11/2012 04:50 AM, zhangyanfei wrote:
> This patch is to implement the feature that at initialization of
> kvm_intel module, fills VMCSINFO with a VMCS revision identifier,
> and encoded offsets of VMCS fields. The reason why we put the
> VMCSINFO processing at the initialization of kvm_intel module
> is that it's dangerous to rob VMX resources while kvm module is
> loaded.

Maybe it should be done by a separate module.

> +
> +	kvm_cpu_vmxon(__pa(per_cpu(vmxarea, raw_smp_processor_id())));
> +	vmcs_load(vmcs);

Should do this after writing into the vmcs directly (vmcs_load() may
cache some information for vmcs_read()).

> +
> +	VMCSINFO_REVISION_ID(vmcs->revision_id);
> +
> +	/*
> +	 * Write encoded offsets into VMCS data for later vmcs_read.
> +	 */
> +	for (offset = FIELD_START; offset < vmcs_config.size;
> +	     offset += sizeof(u16))
> +		*(u16 *)((char *)vmcs + offset) = ENCODING_OFFSET(offset);

This assumes vmcs field contents use the same encoding as
vmread/vmwrite.  I guess it's a reasonable assumption.


-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
