Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1421966263.21823.6.camel@infradead.org>
Subject: Re: Fwd: [PATCH] arm64: Read reg property based on address-cells
 value.
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 22 Jan 2015 14:37:43 -0800
In-Reply-To: <54C0D3AE.9040405@huawei.com>
References: <1421913506-18587-1-git-send-email-anurup.m@huawei.com>
 <54C0D3AE.9040405@huawei.com>
Mime-Version: 1.0
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
To: Anurup M <anurup.m@huawei.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, "sanil.kumar@hisilicon.com" <sanil.kumar@hisilicon.com>, kexec@lists.infradead.org, dingtianhong@huawei.com

Hi Anurup,

On Thu, 2015-01-22 at 16:10 +0530, Anurup M wrote:
>     I have faced an issue during dtb file matching for CPU reg property. The dtb file which
> I use has 32 bit value in the reg property as the #address-cells is 1. The kexec-tools code
> reads the reg as a 64bit values and reads a invalid value and hence the below comparison in
> the function fixup_cpu_nodes fails.

Thanks for reporting. I pushed out a fix very similar to yours.  I only
tested on a dtb with address-cells=2 though.  Let me know if it doesn't
work for you.

 git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
