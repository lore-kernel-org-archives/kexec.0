Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBGcG-0008Ew-ED
 for kexec@lists.infradead.org; Tue, 02 Apr 2019 10:26:05 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Tue, 2 Apr 2019 10:22:08 +0000
Message-ID: <cbe93b95-5bde-c77f-4984-fb982a3cb24f@ce.jp.nec.com>
References: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402094149.GB1555@localhost.localdomain>
 <20190402095350.GA20733@jeru.linux.bs1.fc.nec.co.jp>
 <20190402110635.GC1555@localhost.localdomain>
In-Reply-To: <20190402110635.GC1555@localhost.localdomain>
Content-Language: ja-JP
Content-ID: <A14B196DC5264A4C9ED9C2E5B572E8BE@gisp.nec.co.jp>
MIME-Version: 1.0
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On 4/2/19 8:06 PM, Chao Fan wrote:
> On Tue, Apr 02, 2019 at 09:53:51AM +0000, Junichi Nomura wrote:
>> On Tue, Apr 02, 2019 at 05:41:49PM +0800, Chao Fan wrote:
>>> [   77.989030] kexec_core: Starting new kernel
>>> early console in extract_kernel
>>> input_data: 0x000000017f6033b1
>>> input_len: 0x00000000008412d4
>>> output: 0x000000017e000000
>>> output_len: 0x0000000001e15844
>>> kernel_total_size: 0x0000000001e2c000
>>> trampoline_32bit: 0x000000000009d000
>>> booted via startup_64()
>>>
>>>
>>> Physical KASLR disabled: no suitable memory region!
>>> ------
>>>
>>> I am not sure whether I have done the right test.
>>> This guest is booted from EFI. Here we can see the kexeced kernel
>>> has completed the compressed boot stage. So I think your PATCH works.
>>
>> Thanks for testing.  If your test bed doesn't boot even with the patch,
>> you could check what was found as RSDP with a debug patch like below.
> 
> Oh no, it booted. I just put the compressed stag log.

Ah, then I think the patch worked as expected. Thanks.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
