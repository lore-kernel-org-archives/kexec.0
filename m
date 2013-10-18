Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x230.google.com ([2607:f8b0:4001:c03::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VX154-0008JE-5A
 for kexec@lists.infradead.org; Fri, 18 Oct 2013 03:50:31 +0000
Received: by mail-ie0-f176.google.com with SMTP id u16so5709575iet.35
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2013 20:50:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131015144810.GI31215@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQUNMDuVZtqud3LBbAmE0SL8ZWLFnc+CSYZm4UfTvNUaOA@mail.gmail.com>
 <20131015144810.GI31215@redhat.com>
Date: Thu, 17 Oct 2013 20:50:07 -0700
Message-ID: <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
From: Yinghai Lu <yinghai@kernel.org>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jacob Shin <jacob.shin@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, WANG Chao <chaowang@redhat.com>

On Tue, Oct 15, 2013 at 7:48 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Mon, Oct 14, 2013 at 11:54:22AM -0700, Yinghai Lu wrote:
>> On Mon, Oct 14, 2013 at 4:46 AM, WANG Chao <chaowang@redhat.com> wrote:
>> User should change crashkernel=X to crashkernel=X,high.
>
> I think if we can extend old syntax of crashkernel=X, then it makes life
> really easy for users.
>
>>
>> As user could forget to update kexec-tools to utilize ",high" feature, and get
>> kdump later fail later.
>
> Previously high reservation (reservation above 896M) will anyway fail. So
> instead of failing, if we try reservation in higher memory areas why that
> would break old kexec-tools?

If thel old kexec-tools would fail, we should let them fail early as possible,
do not reserve at first point.

>
> IOW, previously anyway kexec-tools will not work as no memory will be
> reserved in higher memory area. Now memory will be reserved but old
> kexec-tools should fail as it can't load in that area.
>
> If that works, then one would use crashkernel=X,high only if he is
> particualr that memory reservation comes from area above 4G (despite
> the fact that same memory could have been reserved below 4G too).

My point:
Push user to use ",high" as more as possible, so we only to handle one
path eventually.
for old kernel, leave them to use old grammer. do not need to change it.

Also boot loader should always have different entry for old kernel and
new kernel.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
