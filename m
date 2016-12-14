Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH5Ao-0005Xl-Dz
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 08:44:27 +0000
Date: Wed, 14 Dec 2016 16:44:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2] kexec: add a dummy note for each offline cpu
Message-ID: <20161214084402.GB9239@x1>
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
 <20161214074046.GP1034@x1>
 <CAFgQCTvOiWzKbYOBF-L0A2cmw4OR76Hz33ChHB6VTh0REQEmEA@mail.gmail.com>
 <20161214082501.GA9239@x1>
 <CAFgQCTvcywxOxGm-LvHeTzksYSWrxzwN7zCa9y-LJbsgnjr9Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFgQCTvcywxOxGm-LvHeTzksYSWrxzwN7zCa9y-LJbsgnjr9Xg@mail.gmail.com>
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
To: Liu ping fan <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>

On 12/14/16 at 04:39pm, Liu ping fan wrote:
> On Wed, Dec 14, 2016 at 4:25 PM, Baoquan He <bhe@redhat.com> wrote:
> > On 12/14/16 at 04:15pm, Liu ping fan wrote:
> >> On Wed, Dec 14, 2016 at 3:40 PM, Baoquan He <bhe@redhat.com> wrote:
> >> > On 12/14/16 at 02:11pm, Pingfan Liu wrote:
> >> >> kexec-tools always allocates program headers for each possible cpu. This
> >> >> incurs zero PT_NOTE for offline cpu. We mark this case so that later,
> >> >> the capture kernel can distinguish it from the mistake of allocated
> >> >> program header.
> >> >> The counterpart of the capture kernel comes in next patch.
> >> >
> >> > When you execute dmesg on your testing machine and grep nr_cpu_ids,
> >> > what's the value of nr_cpu_ids?
> >> >
> >> nr_cpu_ids=128
> >
> > And what's the cpu number of in "lscpu" command?
> 
> NUMA node1 CPU(s):     0-7
> 
> The system booted up with 128 possible cpu and only 8 online.
> Also I tested on x86 guest, after bootup with 8 cpus, then  offline 4
> of them, the zero PT_NOTE warning buzz too.

Yes, this is what I think not quite appropriate using
for_each_cpu_not(cpu, cpu_online_mask). Maybe it need try to save on
those cpus which is present but not online. not online seems not good,
it's not reasonable to save those getting apic but no cpu plugged.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
