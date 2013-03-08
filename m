Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UE00t-000471-Ll
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 16:19:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <87k3piri3e.fsf@xmission.com>
 <20130308155216.GB8219@redhat.com>
Date: Fri, 08 Mar 2013 08:19:09 -0800
In-Reply-To: <20130308155216.GB8219@redhat.com> (Vivek Goyal's message of
 "Fri, 8 Mar 2013 10:52:16 -0500")
Message-ID: <87boatooea.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to
 speedup kernel dump process
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, hpa@zytor.com, yinghai@kernel.org, Jingbai Ma <jingbai.ma@hp.com>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Mar 07, 2013 at 01:54:45PM -0800, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> > I think this is not a good idea. It has several issues.
>> 
>> Actually it does not appear to be doing any work in the first kernel.
>
> Looks like patch3 in series is doing that.
>
>                         machine_crash_shutdown(&fixed_regs);
> +                       generate_crash_dump_bitmap();
>                         machine_kexec(kexec_crash_image);
>
> So this bitmap seems to be being set just before transitioning into
> second kernel.
>
> I am sure you would not like this extra code in this path. :-)

Ouch!  I had totally missed that.  No that is not at all acceptable.

I was blind that day.  The only call I saw was in patch 4 that put
the call generated the bitmap in the new proc file.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
