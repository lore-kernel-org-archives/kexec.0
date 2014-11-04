Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XlcR9-0000yN-Hn
 for kexec@lists.infradead.org; Tue, 04 Nov 2014 11:38:12 +0000
Received: by mail-ie0-f178.google.com with SMTP id rp18so7324338iec.9
 for <kexec@lists.infradead.org>; Tue, 04 Nov 2014 03:37:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
 <20141024105111.GD24265@leverpostej>
 <CACxGe6szzOXHkK9ukpcSBZgeyy5AgX3+7PgQseBnB9XWYLj-PQ@mail.gmail.com>
 <20141024122738.GH24265@leverpostej> <1414799092.23621.48.camel@smoke>
 <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 4 Nov 2014 11:37:30 +0000
Message-ID: <CACxGe6tWnM6OhAaoYpHdPxbv395EwZyVpuo0hYobx-S1RArPow@mail.gmail.com>
Subject: Re: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
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
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Ian.Campbell@citrix.com" <Ian.Campbell@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Leif Lindholm <leif.lindholm@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Mon, Nov 3, 2014 at 10:26 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Oct 31, 2014 at 6:44 PM, Geoff Levand <geoff@infradead.org> wrote:
>> On Fri, 2014-10-24 at 13:27 +0100, Mark Rutland wrote:
>> Current user space kexec utilities use /proc/device-tree and nothing
>> else.  The intension of the device tree is to describe the system
>> sufficiently for a kernel to boot, so I think we should put the
>> /memreserve/ info into /proc/device-tree.
>>
>> We could put the /memreserve/ entries in there directly, or convert
>> to reserved-memory nodes.  At the moment I like the idea to convert to
>> reserved-memory nodes.
>
> I'm just wondering does UEFI being used for the memory information
> have any impact here as the DT would not have valid memory nodes
> either? I'd assume reserved memory comes from UEFI (or both) in that
> case?

It should, but as always the answer is not simple. UEFI+DT, it may be
that a CMA region is specified in /reserved-memory and we would want
to respect that, even when getting memory information from UEFI.

However, the /memreserve/ section shouldn't be an issue in this case.
Anything firmware needs protected must be reflected in the UEFI memory
map.

g.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
