Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3V5b-0007z0-MT
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 18:21:20 +0000
Message-ID: <52D6D16C.8060207@zytor.com>
Date: Wed, 15 Jan 2014 10:20:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v10] x86, apic, kexec,
 Documentation: Add disable_cpu_apicid kernel parameter
References: <20140115064458.1545.38775.stgit@localhost6.localdomain6>
 <20140115170525.GF3180@redhat.com> <52D6C4B6.8010804@zytor.com>
 <20140115174714.GG3180@redhat.com> <52D6CB57.8030804@zytor.com>
 <20140115181426.GC29244@redhat.com>
In-Reply-To: <20140115181426.GC29244@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On 01/15/2014 10:14 AM, Vivek Goyal wrote:
> 
> For large amount of info like memory map, I agree that passing on command
> line is not a good idea. (/me taks the blame for doing that). That's why
> in new patches I want to move to pass new map on bootparams and pass
> saved_max_pfn on command line instead. This is a fresh start so we
> probably can ignore compatibility with older kernels for this new
> interface and set things right.
> 
> But for smaller options, command line seems to be good that they don't
> consume precious space in bootparams. If we introduce an option today,
> we are not sure if kdump will continue to use that option down the line
> or not. For example, few years down the line, we might be able to send
> INIT IPI to boot cpu too and not need disable_cpu_apicid. Same is the case
> with max_cpus vs nr_cpus. We used to use max_cpus=1 and now use nr_cpus=1.
> If we put all this informatoin in bootparams, they might soon become
> obsolete and keep on sitting there for eternity with no users.
> 
> Also by creating a command line, a user can use these knobs as debugging
> options and can easily test first kernel's behavior to make sure knob
> works well in first kernel before it is tested in second kernel. By making
> it part of bootparams, we have no idea whether knob works fine in first
> kernel or not.
> 
> For above reasons, I am not averse to the idea of commingling.
> 

bootparams is not a precious resource, and even if it was, you could
create your own (kexec) structure and put it in the boot_info linked
list.  bootparams is not a precious resource because is is actually
rather straightforward to extend past 4K should it become necessary; all
we really would need to do there is to include a length field in the
structure.  An auxiliary bootparams structure is also a possibility.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
