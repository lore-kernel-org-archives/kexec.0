Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XhcbX-00011l-QP
 for kexec@lists.infradead.org; Fri, 24 Oct 2014 11:00:25 +0000
Received: by mail-qg0-f41.google.com with SMTP id a108so745909qge.28
 for <kexec@lists.infradead.org>; Fri, 24 Oct 2014 03:59:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141024105111.GD24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
 <20141024105111.GD24265@leverpostej>
From: Grant Likely <grant.likely@linaro.org>
Date: Fri, 24 Oct 2014 11:59:38 +0100
Message-ID: <CACxGe6szzOXHkK9ukpcSBZgeyy5AgX3+7PgQseBnB9XWYLj-PQ@mail.gmail.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ian.campbell@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 24, 2014 at 11:51 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
>> Device tree regions described by /memreserve/ entries are not available in
>> /proc/device-tree, and hence are not available to user space utilities that use
>> /proc/device-tree.  In order for these regions to be available, convert any
>> arm64 DTS files using /memreserve/ entries to use reserved-memory nodes.
>
> The limitation here is in the kernel (and a partially in userspace), so
> modifying the dts files is a workaround rather than a fix.
>
> It's perfectly valid for people to remain using /memreserve/, so this
> isn't sufficient. There are also existing DTBs using /memreserve/ which
> we can't rely on being modified to use reserved-memory.
>
> I think we need to expose memreserves to userspace somehow, potentially
> along with other DTB header fields. Grant, ideas?

Yes, I suggested the same thing to Geoff in a separate thread. Here's
what I wrote:

>> Geoff Levand wrote:
>>> I did some work on this and I think we just need to convert all the
>>> arm64 dts from /memreserve/ to reserved-memory nodes and update the
>>> arm64 booting.txt to specify using reserved-memory.  I'll prepare a
>>> patch for it.
>>
>> I don't think that is going to be entirely sufficient. There will be
>> platforms that don't get converted over, and this is a generic problem
>> that covers all architectures using DT, not just aarch64. The solution
>> probably needs to include exposing the /memreserve/ sections to
>> userspace. I can see two ways to do this:
>>
>> 1) Create a new property in /sysfs with all the memreserve sctions
>> 2) Live-modify the device tree to put the memreserve data into a node
>> at boot time.
>>
>> Option 2 is probably the most generic solution, but it will require
>> some care to make sure there aren't any overlaps if a reserved-memory
>> node already exists.
>>
>> g.
>
> For reference, here is an old conversation about this exact thing.
> Reading through it, the opinions I expressed then don't necessarily
> match what I think now. I still don't think it is a good idea to
> expose the physical address of the old .dtb blob, but I do agree that
> the memreserve sections need to be exposed.
>
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-July/083993.html
>
> g.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
