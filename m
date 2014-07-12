Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1405123436.4264.21.camel@smoke>
Subject: Re: kexec for aarch64_be
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 11 Jul 2014 17:03:56 -0700
In-Reply-To: <CAOdCjQsHUBS9B_Wxe+qbc=k8L3bL145Y2rF+sN=DFvC2BByT9w@mail.gmail.com>
References: <CAOdCjQt73aTLUpGzgQMuSs_aO4RnurArWQoTAFqymBMKTsHe0g@mail.gmail.com>
 <1404932264.26155.75.camel@smoke>
 <CAOdCjQvyzJiNbCijMHU+HowSZknNbEFWh74RM+bzUt2hzZw5Jw@mail.gmail.com>
 <1405013413.4264.11.camel@smoke>
 <CAOdCjQsHUBS9B_Wxe+qbc=k8L3bL145Y2rF+sN=DFvC2BByT9w@mail.gmail.com>
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
To: Pankaj Pandey <pankaj.embedded@gmail.com>
Cc: kexec <kexec@lists.infradead.org>

Hi Pankaj,

On Fri, 2014-07-11 at 13:10 +0530, Pankaj Pandey wrote:
> get_memory_ranges_dt: node_1552 memory
> get_memory_ranges_dt:  RAM: 0000004000000000 - 0000004400000000
> get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
> get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
> get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
> get_memory_ranges_dt: Success
> p_vaddr: ffffffc000080000
> kexec: kexec/arch/arm64/kexec-arm64.c:242: virt_to_phys: Assertion
> `arm64_mem.memstart' failed.

I pushed out a fix for this (zero length memory sections) to my
master branch today.  Please pull and try again.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
