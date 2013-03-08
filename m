Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDzas-0005EA-9N
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 15:52:27 +0000
Date: Fri, 8 Mar 2013 10:52:16 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel
 to speedup kernel dump process
Message-ID: <20130308155216.GB8219@redhat.com>
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <87k3piri3e.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k3piri3e.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, hpa@zytor.com, yinghai@kernel.org, Jingbai Ma <jingbai.ma@hp.com>

On Thu, Mar 07, 2013 at 01:54:45PM -0800, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Thu, Mar 07, 2013 at 10:58:18PM +0800, Jingbai Ma wrote:
> >> This patch intend to speedup the memory pages scanning process in
> >> selective dump mode.
> >> 
> >> Test result (On HP ProLiant DL980 G7 with 1TB RAM, makedumpfile
> >> v1.5.3):
> >> 
> >> 						Total scan Time
> >> Original kernel
> >> 	+ makedumpfile v1.5.3 cyclic mode	1958.05 seconds
> >> Original kernel
> >> 	+ makedumpfile v1.5.3 non-cyclic mode	1151.50 seconds
> >> Patched kernel
> >> 	+ patched makedumpfile v1.5.3		17.50 seconds
> >> 
> >> Traditionally, to reduce the size of dump file, dumper scans all memory
> >> pages to exclude the unnecessary memory pages after capture kernel
> >> booted, and scan it in userspace code (makedumpfile).
> >
> > I think this is not a good idea. It has several issues.
> 
> Actually it does not appear to be doing any work in the first kernel.

Looks like patch3 in series is doing that.

                        machine_crash_shutdown(&fixed_regs);
+                       generate_crash_dump_bitmap();
                        machine_kexec(kexec_crash_image);

So this bitmap seems to be being set just before transitioning into
second kernel.

I am sure you would not like this extra code in this path. :-)

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
