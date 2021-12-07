Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muUdw-007BPw-Nb
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 07:12:06 +0000
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for
 user pointer
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com> <20211206140451.GA4936@lst.de>
From: Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <08e4e9d8-2c42-115a-f440-d7f44fb19280@arm.com>
Date: Tue, 7 Dec 2021 12:41:52 +0530
MIME-Version: 1.0
In-Reply-To: <20211206140451.GA4936@lst.de>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>



On 12/6/21 7:34 PM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 04:12:18PM +0530, Amit Daniel Kachhap wrote:
>> +	return read_from_oldmem_to_kernel(buf, count, ppos,
>> +					  cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
> 
> Overly long line.
> 
>> +ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
>> +			 u64 *ppos, bool encrypted)
>>   {
>>   	unsigned long pfn, offset;
>>   	size_t nr_bytes;
>> @@ -156,19 +163,27 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>>   		/* If pfn is not ram, return zeros for sparse dump files */
>>   		if (!pfn_is_ram(pfn)) {
>>   			tmp = 0;
>> -			if (!userbuf)
>> -				memset(buf, 0, nr_bytes);
>> -			else if (clear_user(buf, nr_bytes))
>> +			if (kbuf)
>> +				memset(kbuf, 0, nr_bytes);
>> +			else if (clear_user(ubuf, nr_bytes))
>>   				tmp = -EFAULT;
> 
> This looks like a huge mess.  What speak against using an iov_iter
> here?

iov_iter seems to be a reasonable way. As a start I thought of adding
minimal changes.

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
