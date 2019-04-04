Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBr79-0007xq-79
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 01:24:24 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Thu, 4 Apr 2019 01:23:26 +0000
Message-ID: <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
References: <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
In-Reply-To: <20190403090210.GH1555@localhost.localdomain>
Content-Language: ja-JP
Content-ID: <D8F13C0C845E5C4F8800DDBABD57EC59@gisp.nec.co.jp>
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, Dave Young <dyoung@redhat.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

Hi Dave and Chao,

On 4/3/19 6:02 PM, Chao Fan wrote:
> On Wed, Apr 03, 2019 at 04:23:06PM +0800, Chao Fan wrote:
>> On Wed, Apr 03, 2019 at 04:09:16PM +0800, Dave Young wrote:
>>> Fix 3.  need more debugging, have you or Junichi run tests on more real
>>> hardware, maybe it is easier to reproduce on real hardware, I'm glad to
>>> help to try test patch or provide any help. 
>>
>> I am still testing in real hardware.
> 
> Hi Dave,
> 
> I find a Fujitsu Desktop PC to test it.
> Without this PATCH, it failed to kexec and kdump.
> With this PATCH, it succeed to kexec.
> But failed to kdump. From the log, I think it didn't jump to the second
> kernel, just reboot after panic. I have not figured out what's the
> problem, but it seems not caused by this PATCH.
> So I still think this PATCH works for the Fujitsu Desktop PC.
> 
> As for your issue, I think there may be some problems related to specified
> hardware. Are you using a Lenovo laptop?
> 
> And I am not sure how Nomura tested it.

I've tested 3 different models of EFI-booted baremetal servers with both
normal kexec and panic kexec.  So far as I've tried Linus's v5.1-rc3,
the problem always reproduced without the patch and disappears with the patch.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
