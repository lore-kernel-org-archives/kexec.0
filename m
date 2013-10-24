Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x231.google.com ([2607:f8b0:4001:c03::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZQNm-0002sP-3Y
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 19:15:46 +0000
Received: by mail-ie0-f177.google.com with SMTP id e14so4582671iej.8
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 12:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131024140241.GA2322@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
 <CAE9FiQUNMDuVZtqud3LBbAmE0SL8ZWLFnc+CSYZm4UfTvNUaOA@mail.gmail.com>
 <20131015144810.GI31215@redhat.com>
 <CAE9FiQXVCx__SuhAdO9_CNaRncW2HB2tv3UjZrQcbsTV35QWow@mail.gmail.com>
 <20131018123837.GB2277@redhat.com>
 <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
 <20131021151643.GA20669@redhat.com>
 <CAE9FiQVfeUdugFRMt1DGjtqW2FAb2gfnGjXENHjoJ=JVAYbYgw@mail.gmail.com>
 <20131024140241.GA2322@redhat.com>
Date: Thu, 24 Oct 2013 12:15:25 -0700
Message-ID: <CAE9FiQUu0WwMgNpog4TKch+MT2i7_DsNvqZxbyQusS4AFxdhQQ@mail.gmail.com>
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

On Thu, Oct 24, 2013 at 7:02 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Wed, Oct 23, 2013 at 11:11:51PM -0700, Yinghai Lu wrote:
>
> Hence both crashkernel=xM and crashkernel=XM,high have their own usage.
> We have been using crashkernel=xM and we know it works. So extending it
> to be able to allocate memory from higher regions, if sufficient memory
> is not available in lower regions makes sense. Memory reservation below
> 4G is more efficient due to not requiring swiotlb. And crashkernel=xM
> has been working for us and users are familiar with it.
>
> So I don't see a point that why would you try to block any move to
> extend crashkernel=xM semantics.

Make the thing simple.
Keep them separately, leave crashkernel=xM to old kexec-tools mostly
and keep crashkernel=xM,high to newer kexec-tools as needed.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
