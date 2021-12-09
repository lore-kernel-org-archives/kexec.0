Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvLXY-00GZsy-1S
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 15:41:01 +0000
Message-ID: <5e468446-264d-ed8c-33f8-13f717bc6f9d@oracle.com>
Date: Thu, 9 Dec 2021 09:40:18 -0600
Subject: Re: [RFC v2 4/6] crash hp: generic crash hotplug support
 infrastructure
Content-Language: en-US
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <20211207195204.1582-5-eric.devolder@oracle.com>
 <9230f9cc-1001-e3ce-aa74-10b766c8cdb0@redhat.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <9230f9cc-1001-e3ce-aa74-10b766c8cdb0@redhat.com>
MIME-Version: 1.0
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
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com



On 12/8/21 07:38, David Hildenbrand wrote:
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +	unsigned long val, void *v)
>> +{
>> +	struct memory_notify *mhp = v;
>> +	unsigned long start, end;
>> +
>> +	start = mhp->start_pfn << PAGE_SHIFT;
>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>> +
>> +	switch (val) {
>> +	case MEM_GOING_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			start, end-start);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +	case MEM_CANCEL_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			start, end-start);
> 
> Any reason you don't handle this after the effects completely, meaning
> MEM_ONLINE and MEM_OFFLINE?
> 

No, no reason. Great catch! I've changed it to use MEM_ONLINE/OFFLINE only.
Thanks!
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
