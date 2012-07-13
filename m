Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SphDW-0005Qs-QV
 for kexec@lists.infradead.org; Fri, 13 Jul 2012 14:51:40 +0000
Message-ID: <500035EB.1020502@citrix.com>
Date: Fri, 13 Jul 2012 15:51:23 +0100
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 1/5] xen: Always calculate max_cpus value
References: <20120705145839.GB2007@host-192-168-1-59.local.net-space.pl>
 <20120705150008.GC2007@host-192-168-1-59.local.net-space.pl>
 <4FF5D557020000780008DEA5@nat28.tlf.novell.com>
 <20120713131907.GB1876@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20120713131907.GB1876@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, xen-devel <xen-devel@lists.xen.org>, "anderson@redhat.com" <anderson@redhat.com>, Jan Beulich <JBeulich@suse.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>

On 13/07/12 14:19, Daniel Kiper wrote:
> On Thu, Jul 05, 2012 at 04:56:39PM +0100, Jan Beulich wrote:
>>>>> On 05.07.12 at 17:00, Daniel Kiper <daniel.kiper@oracle.com> wrote:
>>> max_cpus is not available since 20374 changeset (Miscellaneous data
>>> placement adjustments). It was moved to __initdata section. This section
>>> is freed after Xen initialization. Assume that max_cpus is always
>>> equal to XEN_HYPER_SIZE(cpumask_t) * 8.
>> Using nr_cpu_ids, when available, would seem a better fit. And
> Hmmm... I could not find such animal in Xen source code.
> However, maybe I missed something.

nr_cpu_ids was introduced into xen-unstable with c/s 23982:511d5e65a302

It is not present in 4.1 or earlier.

~Andrew

>
>> I donm't see why, on dumps from old hypervisors, you wouldn't
>> want to continue using max_cpus. Oh, wait, I see - you would
>> have to be able to tell whether it actually sits in .init.data, which
>> might not be strait forward.
> Yep, but I will try to improve that once again.
>
> Daniel

-- 
Andrew Cooper - Dom0 Kernel Engineer, Citrix XenServer
T: +44 (0)1223 225 900, http://www.citrix.com




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
