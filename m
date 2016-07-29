Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20160726080925.GA2363@linaro.org>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Fri, 29 Jul 2016 19:26:03 +0300
Message-ID: <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
Subject: Re: [PATCH v23 0/9] arm64: add kdump support
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, Geoff Levand <geoff@infradead.org>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, Mark Rutland <mark.rutland@arm.com>, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

On Tue, Jul 26, 2016 at 11:09 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Tue, Jul 26, 2016 at 04:56:51PM +0900, AKASHI Takahiro wrote:
>> This patch series adds kdump support on arm64.
>>
>> To load a crash-dump kernel to the systems, a series of patches to
>> kexec-tools, which have not yet been merged upstream, are needed.
>> Please pick Geoff's kexec patches [1] and my kdump patches [2].
>>
>> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>>   - crash utility (coming v7.1.6 or later) [3]
>>     (Necessary patches have already been queued in the master.)
>>
>> [1]  http://lists.infradead.org/pipermail/kexec/2016-July/016532.html
>> [2]  TBD
>
> See my kexec-tools patches in:
> http://lists.infradead.org/pipermail/kexec/2016-July/016642.html

I tired this patch series with mentioned Geoff's kexec patches and
your kdump patches, but unfortunately it doesn't work for me.

While I can successfully load and kexec the kernel ('kexec --load' +
'kexec -e'), same combination of kernel+ramdisk+dtb doesn't boot
if I do kdump combination ('kexec -p' + sysrq crash), there is no
any output after sysrq crash trace.
Unfortunately I don't have any debugger here for deep investigation
of this issue.

Also for some reason in case of 'load and kexec the kernel' it
takes 1-2 minutes to start booting after I do kexec -e, need to
investigate it further.

Which hardware do you use for validating your patches?

Also, could you please share exact commands you use for
kdump validation?

Best regaerds,
Ruslan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
