Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
 <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com> <Yc2MprJJsm7LagGc@zn.tnic>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7a703955-cd1c-e074-17dd-a9155aa7690a@huawei.com>
Date: Thu, 30 Dec 2021 19:08:56 +0800
MIME-Version: 1.0
In-Reply-To: <Yc2MprJJsm7LagGc@zn.tnic>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>



On 2021/12/30 18:40, Borislav Petkov wrote:
> On Thu, Dec 30, 2021 at 06:14:59PM +0800, Leizhen (ThunderTown) wrote:
>>
>> Hi, Dave, Baoquan, Borislav:
>>   What do you think about the introduction of parse_crashkernel_high_low()? If everyone
>> doesn't object, I'll bring it to the next version. But I'll make some adjustments to the
>> patches, see below. If there's any objection, I still strongly recommend removing the
>> parameters "system_ram" and "crash_base" of parse_crashkernel_{high,low}().
>>
>> How about splitting __parse_crashkernel() into two parts? One for parsing
>> "crashkernel=X[@offset]", another one for parsing "crashkernel=X,{high,low}" and other
>> suffixes in the future. So the parameter requirements are clear at the lowest level.
> 
> First of all, please do not top post!
> 
> Now, I already explained to you what I'd like to see:
> 
> https://lore.kernel.org/r/Ycs3kpZD/vpoo1AX@zn.tnic
> 
> yet you still don't get it.
> 
> So let me make myself clear: in its current form, this is not really an
> improvement so for all x86 changes:
> 
> NAKed-by: Borislav Petkov <bp@suse.de>
> 

OK, thanks for your immediate reply, so I can take less detours.

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
