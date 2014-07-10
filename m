Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1405013413.4264.11.camel@smoke>
Subject: Re: kexec for aarch64_be
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 10 Jul 2014 10:30:13 -0700
In-Reply-To: <CAOdCjQvyzJiNbCijMHU+HowSZknNbEFWh74RM+bzUt2hzZw5Jw@mail.gmail.com>
References: <CAOdCjQt73aTLUpGzgQMuSs_aO4RnurArWQoTAFqymBMKTsHe0g@mail.gmail.com>
 <1404932264.26155.75.camel@smoke>
 <CAOdCjQvyzJiNbCijMHU+HowSZknNbEFWh74RM+bzUt2hzZw5Jw@mail.gmail.com>
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

On Thu, 2014-07-10 at 19:29 +0530, Pankaj Pandey wrote:
> memory ranges:
>  Skip: 000000001c020000 - 000000001c020020 : serial
>  Add:  0000004000000000 - 0000004400000000 : System RAM
>  Skip: 0000004000080000 - 00000040008ac5e4 : Kernel code
>  Skip: 00000040008dc000 - 0000004000a8e4d8 : Kernel data
>  Skip: 000000e0d0000000 - 000000e0d0200000 : cfg
> elf_arm64_probe:27: ->
> elf_arm64_probe:46: <-
> elf_arm64_load:65: ->
> add_segment:112: ->
> virt_to_phys:104: ffffffc000080000 -> ffffffc080080000
> Invalid memory segment 0xffffffc080080000 - 0xffffffc080a8efff

This output does not look familiar.  I can only
guess you are using an old version of my kexec-tools.

Please use the latest from the 'master' branch here, and
post the output:

  git://git.linaro.org/people/geoff.levand/kexec-tools.git

-Geoff
  

  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
