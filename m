Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com> <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com> <YcwyZRDJUMniSaY9@zn.tnic>
 <Ycw8n2BvJzH9wJKG@dhcp-128-65.nay.redhat.com>
 <21736ba2-883d-1037-dbe8-299e40f7ad13@huawei.com> <YcySEdyhXysDSKn/@zn.tnic>
 <933554c7-1fc6-8e7a-9569-9f8441e50ddf@huawei.com>
Message-ID: <1f5b61b0-24b1-0cbe-5c2b-aef5df020c48@huawei.com>
Date: Thu, 30 Dec 2021 16:56:00 +0800
MIME-Version: 1.0
In-Reply-To: <933554c7-1fc6-8e7a-9569-9f8441e50ddf@huawei.com>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen
 Zhou <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>



On 2021/12/30 10:39, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/30 0:51, Borislav Petkov wrote:
>> On Wed, Dec 29, 2021 at 11:04:21PM +0800, Leizhen (ThunderTown) wrote:
>>> Chen Zhou and I tried to share the code because of a suggestion. After so many
>>> attempts, it doesn't seem to fit to make generic. Or maybe I haven't figured
>>> out a good solution yet.
>>
>> Well, you learned a very important lesson and the many attempts are not
>> in vain: code sharing does not make sense in every case.
>>
>>> I will put the patches that make arm64 support crashkernel...high,low to
>>> the front, then the parse_crashkernel() unification patches. Even if the
>>> second half of the patches is not ready for v5.18, the first half of the
>>> patches is ready.
>>
>> I think you should concentrate on the arm64 side which is, AFAICT, what
>> you're trying to achieve.
> 
> Right, a patchset should focus on just one thing.
> 
>>
>> The "parse_crashkernel() unification" needs more thought because, as I
>> said already, that doesn't make a whole lot of sense to me.
> 
> Yes, because it's not a functional improvement, it's not a performance optimization,
> it's also not a fix for a known bug, it's just a programmer's artistic pursuit.
> 
>>
>> If you want to enforce the fact that "low" makes sense only when "high"
>> is supplied, parse_crashkernel_high_low() is not the right thing to do.
>> You need to have a *single* function which does all the parsing where
>> you can decide what to do: "if high, parse low", "if no high supplied,
>> ignore low" and so on.

In fact, this is how my current function parse_crashkernel_high_low() is
implemented.

+	/* crashkernel=X,high */
+	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
+	if (ret)			//crashkernel=X,high is not specified
+		return ret;
+
+	if (*high_size <= 0)		//crashkernel=X,high is specified but the value is invalid
+		return -EINVAL;		//Sorry, the type of high_size is "unsigned long long *", so less than zero is impossible
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);	//If crashkernel=Y,low is specified, the parsed value is stored in *low_size
+	if (ret)
+		*low_size = -1;		//crashkernel=Y,low is not specified


> 
> I understand your proposal, but parse_crashkernel_high_low() is a cost-effective
> and profitable change, it makes the current code a little clearer, and avoid passing
> unnecessary parameters "system_ram" and "crash_base" when other architectures use
> parse_crashkernel_{high|low}().
> 
> I actually followed your advice in the beginning to do "parse_crashkernel() and
> parse_crashkernel_{high|low}() unification". But I found it's difficult and the
> end result may not be as good as expected. So I introduced parse_crashkernel_high_low().
> 
> The parameter "system_ram" and "crash_base" of parse_crashkernel() is not need by
> "crashkernel=X,[high,low]". And parameter "low_size" of parse_crashkernel_high_low()
> is not need by "crashkernel=X[@offset]". The "parse_crashkernel() unification"
> complicates things. For example, the parameter "crash_size" means "low or high" memory
> size for "crashkernel=X[@offset]", but only means "high" memory size for "crashkernel=X,high".
> So we'd better give it two names with union.
> 
>>
>> And if those are supported on certain architectures only, you can do
>> ifdeffery...
> 
> I don't think so. These __init functions are small and architecture-independent, and do not
> affect compilation of other architectures. There may be other architectures that use
> it in the future, such as the current arm64.
> 
>>
>> But I think I already stated that I don't like such unifications which
>> introduce unnecessary dependencies between architectures. Therefore, I
>> won't accept them into x86 unless there's a strong compelling reason.
>> Which I don't see ATM.
> 
> OK.
> 
>>
>> Thx.
>>
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
