Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SfA6Y-0004oe-Go
 for kexec@lists.infradead.org; Thu, 14 Jun 2012 13:28:55 +0000
Message-ID: <4FD9E70A.9090507@redhat.com>
Date: Thu, 14 Jun 2012 16:28:42 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] x86: Add helper variables and functions to hold
 VMCSINFO
References: <4FB35C48.30708@cn.fujitsu.com> <4FB35CD4.3080801@cn.fujitsu.com>
In-Reply-To: <4FB35CD4.3080801@cn.fujitsu.com>
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
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

On 05/16/2012 10:52 AM, zhangyanfei wrote:
> This patch provides a set of variables to hold the VMCSINFO and also
> some helper functions to help fill the VMCSINFO.

Need to document the format.


> +void vmcsinfo_append_id(u32 id)
> +{
> +	size_t r;
> +
> +	r = sizeof(id);
> +	if (r + vmcsinfo_size > vmcsinfo_max_size)
> +		return;
> +
> +	memcpy(&vmcsinfo_data[vmcsinfo_size], &id, r);
> +	vmcsinfo_size += r;
> +}
> +EXPORT_SYMBOL_GPL(vmcsinfo_append_id);
> +
> +void vmcsinfo_append_field(u32 field, u64 offset)

Why u64?  It's guaranteed to fit within a page.

> +{
> +	size_t r;
> +
> +	r = sizeof(field) + sizeof(offset);
> +	if (r + vmcsinfo_size > vmcsinfo_max_size)
> +		return;
> +
> +	memcpy(&vmcsinfo_data[vmcsinfo_size], &field, sizeof(field));
> +	vmcsinfo_size += sizeof(field);
> +	memcpy(&vmcsinfo_data[vmcsinfo_size], &offset, sizeof(offset));
> +	vmcsinfo_size += sizeof(offset);

Instead of this vmcsinfo_data, how about a struct with fields for the
revision ID and field count, and an array for the fields?  Should be a
lot simpler.

> +}
> +EXPORT_SYMBOL_GPL(vmcsinfo_append_field);
> +
> +unsigned long paddr_vmcsinfo_note(void)
> +{
> +	return __pa((unsigned long)(char *)&vmcsinfo_note);
> +}
> 


-- 
error compiling committee.c: too many arguments to function



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
