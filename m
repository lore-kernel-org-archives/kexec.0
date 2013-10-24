Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x236.google.com ([2607:f8b0:4001:c03::236])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZE9Z-00065K-Nx
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 06:12:18 +0000
Received: by mail-ie0-f182.google.com with SMTP id as1so3137162iec.27
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 23:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131021151643.GA20669@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQUNMDuVZtqud3LBbAmE0SL8ZWLFnc+CSYZm4UfTvNUaOA@mail.gmail.com>
 <20131015144810.GI31215@redhat.com>
 <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
 <20131018123837.GB2277@redhat.com>
 <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
 <20131021151643.GA20669@redhat.com>
Date: Wed, 23 Oct 2013 23:11:51 -0700
Message-ID: <CAE9FiQVfeUdugFRMt1DGjtqW2FAb2gfnGjXENHjoJ=JVAYbYgw@mail.gmail.com>
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

On Mon, Oct 21, 2013 at 8:16 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Fri, Oct 18, 2013 at 10:45:43PM -0700, Yinghai Lu wrote:
>
>
> IIUC, you are trying to say that with new kernel old kexec-tools will fail
> at a different failure point. I don't see why that is a problem. It still
> fails.

Yes, that could cause confusion.

We already knew it would fail possible at most later, we should make
it skip allocation during first kernel booting.

>
> [..]
>> > You are not thinking about ease of use here for existing users.
>>
>> most existing user don't need to do anything. just with new kernel and
>> old kexec tools.
>>
>> those system that did not work kexec before because XM is too big, they have to
>> update kexec tools, and use ",high"
>>
>> Make it simple, less error.
>
> No, it is not that simple. Think from a distribution's perspective also.
> We have the logic to scale reserved memory based on physical memory
> present in the system. Now we are seeing bigger memory systems (which
> would not have worked in the past). We still want to retain the existing
> logic and not switch to crashkernel=x,high. One does not have to. It
> makes life simpler.

distribution should go with ",high" for 64 bit kernel and new kexec-tools.
for 32bit kernel, you still can have ",high" or not, as ",high" is ignored.


>
> Same logic working both with smaller memory systems as well as large memory
> systems. One should not have to choose a different command line because
> there is more physical RAM present in the system.

",high" is working even on smaller memory sytem.

>
>>
>> We already support above 4G, what is point for trying below 4G?
>
> Because it is not *required* to reserve memory above 4G. Because we want
> same command line to work with both small memory systems as well as
> large memory systems and we don't care whether memory is reserved below
> 4G or above 4G. What does matter though that we don't have to worry about
> switching command line option if it is large memory system.

",high" will work smaller or large memory system after you install new
kexec tools.

Again, for distribution, when new kernel is added, new kernel will all
have ",high"
and new kexec-tools get installed.

Even we want to extend crashkernel=XM, then i would like to have
it identical to crashkernel=XM,high instead.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
