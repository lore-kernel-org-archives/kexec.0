Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WJIsO-0002OG-Qf
 for kexec@lists.infradead.org; Fri, 28 Feb 2014 08:33:03 +0000
Date: Fri, 28 Feb 2014 16:32:24 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v2 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140228083224.GC13117@dhcp-17-89.nay.redhat.com>
References: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
 <1392888512-4473-5-git-send-email-chaowang@redhat.com>
 <20140227205312.GJ30210@oranje.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140227205312.GJ30210@oranje.fc.hp.com>
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
To: Linn Crosetto <linn@hp.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "horms@verge.net.au" <horms@verge.net.au>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "trenn@suse.de" <trenn@suse.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 02/27/14 at 01:53pm, Linn Crosetto wrote:
> Hi Chao,
> 
> On Thu, Feb 20, 2014 at 02:28:32AM -0700, WANG Chao wrote:
> 
> [..]
> 
> > +static void setup_e820_ext(struct kexec_info *info, struct x86_linux_param_header *real_mode,
> > +                          struct memory_range *range, int nr_range)
> > +{
> > +       struct setup_data *sd;
> > +       struct e820entry *e820;
> > +       int i, j, nr_range_ext;
> > +
> > +       nr_range_ext = nr_range - E820MAX;
> > +       sd = malloc(sizeof(struct setup_data) + nr_range_ext * sizeof(struct e820entry));
> > +       sd->next = 0;
> > +       sd->len = nr_range_ext * sizeof(struct e820entry);
> > +       sd->type = SETUP_E820_EXT;
> > +
> > +       e820 = (struct e820entry *) sd->data;
> > +       dbgprintf("Extended E820 via setup_data:\n");
> > +       for(i = 0, j = E820MAX; i < nr_range_ext; i++, j++) {
> > +               e820[i].addr = range[j].start;
> > +               e820[i].size = range[j].end - range[j].start;
> > +               switch (range[j].type) {
> > +               case RANGE_RAM:
> > +                       e820[i].type = E820_RAM;
> > +                       break;
> > +               case RANGE_ACPI:
> > +                       e820[i].type = E820_ACPI;
> > +                       break;
> > +               case RANGE_ACPI_NVS:
> > +                       e820[i].type = E820_NVS;
> > +                       break;
> > +               default:
> > +               case RANGE_RESERVED:
> > +                       e820[i].type = E820_RESERVED;
> > +                       break;
> > +               }
> > +               dbgprintf("%016lx-%016lx (%d)\n",
> > +                               e820[i].addr,
> > +                               e820[i].addr + e820[i].size - 1,
> > +                               e820[i].type);
> > +
> > +               if (range[j].type != RANGE_RAM)
> > +                       continue;
> > +               if ((range[j].start <= 0x100000) && range[j].end > 0x100000) {
> > +                       unsigned long long mem_k = (range[j].end >> 10) - (0x100000 >> 10);
> > +                       real_mode->ext_mem_k = mem_k;
> > +                       real_mode->alt_mem_k = mem_k;
> > +                       if (mem_k > 0xfc00) {
> > +                               real_mode->ext_mem_k = 0xfc00; /* 64M */
> > +                       }
> > +                       if (mem_k > 0xffffffff) {
> > +                               real_mode->alt_mem_k = 0xffffffff;
> > +                       }
> > +               }
> > +       }
> > +       add_setup_data(info, real_mode, sd);
> > +       free(sd);
> 
> Remove this call to free(sd) or the kernel will not boot if there are more than
> E820MAX entries.

You're right.

> 
> > +}
> > +
> > +static void setup_e820(struct kexec_info *info, struct x86_linux_param_header *real_mode,
> > +                      struct memory_range *range, int nr_range)
> > +{
> > +
> > +       int nr_range_saved = nr_range;
> > +       int i;
> > +
> > +       if (nr_range > E820MAX) {
> > +               nr_range = E820MAX;
> > +       }
> > +
> > +       real_mode->e820_map_nr = nr_range;
> > +       dbgprintf("E820 memmap:\n");
> > +       for(i = 0; i < nr_range; i++) {
> > +               real_mode->e820_map[i].addr = range[i].start;
> > +               real_mode->e820_map[i].size = range[i].end - range[i].start;
> > +               switch (range[i].type) {
> > +                       case RANGE_RAM:
> > +                               real_mode->e820_map[i].type = E820_RAM;
> > +                               break;
> > +                       case RANGE_ACPI:
> > +                               real_mode->e820_map[i].type = E820_ACPI;
> > +                               break;
> > +                       case RANGE_ACPI_NVS:
> > +                               real_mode->e820_map[i].type = E820_NVS;
> > +                               break;
> > +                       default:
> > +                       case RANGE_RESERVED:
> > +                               real_mode->e820_map[i].type = E820_RESERVED;
> > +                               break;
> > +               }
> > +               dbgprintf("%016lx-%016lx (%d)\n",
> > +                               real_mode->e820_map[i].addr,
> > +                               real_mode->e820_map[i].addr + real_mode->e820_map[i].size - 1,
> > +                               real_mode->e820_map[i].type);
> > +
> > +               if (range[i].type != RANGE_RAM)
> > +                       continue;
> > +               if ((range[i].start <= 0x100000) && range[i].end > 0x100000) {
> > +                       unsigned long long mem_k = (range[i].end >> 10) - (0x100000 >> 10);
> > +                       real_mode->ext_mem_k = mem_k;
> > +                       real_mode->alt_mem_k = mem_k;
> > +                       if (mem_k > 0xfc00) {
> > +                               real_mode->ext_mem_k = 0xfc00; /* 64M */
> > +                       }
> > +                       if (mem_k > 0xffffffff) {
> > +                               real_mode->alt_mem_k = 0xffffffff;
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (nr_range_saved > E820MAX) {
> > +               dbgprintf("extra E820 memmap are passed via setup_data\n");
> > +               setup_e820_ext(info, real_mode, range, nr_range_saved);
> > +       }
> > +}
> > +
> 
> setup_e820() and setup_e820_ext() contain a lot of duplication. You could
> combine them into a single function, similar to the implementation of
> setup_e820() in the kernel.

OK. That makes sense to me.

> 
> >  static int
> >  get_efi_mem_desc_version(struct x86_linux_param_header *real_mode)
> >  {
> > @@ -704,7 +830,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
> 
> [..]
> 
> > +       if (info->kexec_flags & KEXEC_ON_CRASH && !pass_memmap_cmdline) {
> > +               range = crash_memory_range;
> > +               ranges = crash_memory_ranges;
> > +       } else {
> > +               range = info->memory_range;
> > +               ranges = info->memory_ranges;
> >         }
> 
> You can move this code into setup_e820(), since range and ranges are not used
> elsewhere in setup_linux_system_parameters().

Will do.

> 
> > +       setup_e820(info, real_mode, range, ranges);
> > 
> >         /* fill the EDD information */
> >         setup_edd_info(real_mode);
> > --
> > 1.8.5.3
> 
> I tested boot (with the above fix) on a system with a large memory map, and can
> easily test changes, if needed.

Thanks for testing. The result on that real system is helpful and convincing.

I'm holding off v3 for serveral days in case someone would have a
comment.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
