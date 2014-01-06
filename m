Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from omzsmtpe04.verizonbusiness.com ([199.249.25.207])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0G7l-0003Us-Nl
 for kexec@lists.infradead.org; Mon, 06 Jan 2014 19:46:11 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <52CB07E7.7000406@terremark.com>
Date: Mon, 06 Jan 2014 14:45:43 -0500
MIME-Version: 1.0
Subject: Re: [Crash-utility] [PATCH 0/4] Enable use of crash on xen 4.4.0
 vmcore
References: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
 <1761421528.25775303.1389027910680.JavaMail.root@redhat.com>
In-Reply-To: <1761421528.25775303.1389027910680.JavaMail.root@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On 01/06/14 12:05, Dave Anderson wrote:
>
> ----- Original Message -----
>> With the addition on PVH code to xen 4.4, domain.is_hvm no longer
>> exists.  This prevents crash from using a xen 4.4.0 vmcore.
>>
>> Patch 1 "fixes" this.
>>
>> Patch 2 is a minor fix in that outputing the offset in hex for
>> domain_domain_flags is different.
>>
>> Patch 3 is a bug fix to get all "domain_flags" set, not just the 1st
>> one found.
>>
>> Patch 4 is a quick way to add domain.guest_type support.
> Hi Don,
>
> The patch looks good to me.  But for the crash.changelog, can you show
> what happens when you attempt to look at one of these PVH dumps without
> your patches?
>
> Thanks,
>    Dave

Before patch 1:



dcs-xen-54:/big/crash/vmcore-hang-0>~/crash-7.0/crash vmcore xen-syms-4.4-unstable

crash 7.0.4
Copyright (C) 2002-2013  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...


crash: invalid structure member offset: domain_is_hvm
        FILE: xen_hyper.c  LINE: 1250  FUNCTION: xen_hyper_store_domain_context()

[/home/don/crash-7.0/crash] error trace: 54c307 => 54ba5f => 51823b => 460895

   460895: OFFSET_verify.part.25+67
   51823b: OFFSET_verify+43
   54ba5f: xen_hyper_store_domain_context+639
   54c307: xen_hyper_refresh_domain_context_space+151


After patch 1:

dcs-xen-54:/big/crash/vmcore-hang-0>~/crash-7.0/crash vmcore xen-syms-4.4-unstable

crash 7.0.4
Copyright (C) 2002-2013  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

    KERNEL: xen-syms-4.4-unstable
  DUMPFILE: vmcore
      CPUS: 8
   DOMAINS: 5
    UPTIME: --:--:--
   MACHINE: Intel(R) Xeon(R) CPU E31265L @ 2.40GHz  (2400 Mhz)
    MEMORY: 32 GB
   PCPU-ID: 0
      PCPU: ffff82d0802bff18
   VCPU-ID: 0
      VCPU: ffff8300bf2fe000  (VCPU_RUNNING)
DOMAIN-ID: 32767
    DOMAIN: ffff83083a163000  (DOMAIN_RUNNING)
     STATE: CRASH

crash> doms
    DID       DOMAIN      ST T  MAXPAGE  TOTPAGE VCPU SHARED_I          P2M_MFN
   32753 ffff83083a1a7000 RU O     0        0      0 0              ----
   32754 ffff83083a164000 RU X     0        0      0 0              ----
 >*32767 ffff83083a163000 RU I     0        0      8 0              ----
 >     0 ffff830823fb7000 RU 0 ffffffff   80000    8 ffff8300bf504000      81df80
       2 ffff83083f12e000 RU U  100100    fd043    2 ffff8300bf4b6000         0
crash> help -X ofs
                        ELF_Prstatus_pr_info: 0
                      ELF_Prstatus_pr_cursig: 12
                     ELF_Prstatus_pr_sigpend: 16
                     ELF_Prstatus_pr_sighold: 24
                         ELF_Prstatus_pr_pid: 32
                        ELF_Prstatus_pr_ppid: 36
                        ELF_Prstatus_pr_pgrp: 40
                         ELF_Prstatus_pr_sid: 44
                       ELF_Prstatus_pr_stime: 64
                      ELF_Prstatus_pr_cutime: 80
                      ELF_Prstatus_pr_cstime: 96
                         ELF_Prstatus_pr_reg: 112
                     ELF_Prstatus_pr_fpvalid: 328
                          ELF_Timeval_tv_sec: 0
                         ELF_Timeval_tv_usec: 8
                    arch_shared_info_max_pfn: 0
arch_shared_info_pfn_to_mfn_frame_list_list: 8
                 arch_shared_info_nmi_reason: 16
                cpu_info_guest_cpu_user_regs: 0
                       cpu_info_processor_id: 200
                       cpu_info_current_vcpu: 208
                    cpu_time_local_tsc_stamp: 0
                  cpu_time_stime_local_stamp: 0
                 cpu_time_stime_master_stamp: 0
                          cpu_time_tsc_scale: 0
                  cpu_time_calibration_timer: 0
                           crash_note_t_core: -1
                            crash_note_t_xen: -1
                       crash_note_t_xen_regs: -1
                       crash_note_t_xen_info: -1
                      crash_note_core_t_note: -1
                      crash_note_core_t_desc: -1
                       crash_note_xen_t_note: -1
                       crash_note_xen_t_desc: -1
                  crash_note_xen_core_t_note: -1
                  crash_note_xen_core_t_desc: -1
                  crash_note_xen_info_t_note: -1
                  crash_note_xen_info_t_desc: -1
                            domain_page_list: 0
                         domain_xenpage_list: 0
                            domain_domain_id: 0
                            domain_tot_pages: 56
                            domain_max_pages: 64
                        domain_xenheap_pages: 76
                          domain_shared_info: 8
                           domain_sched_priv: 88
                         domain_next_in_list: 104
                         domain_domain_flags: ffffffffffffffff
                               domain_evtchn: 144
                               domain_is_hvm: -1
                        domain_is_privileged: 278
                    domain_debugger_attached: 288
                             domain_is_dying: 292
              domain_is_paused_by_controller: 296
                     domain_is_shutting_down: 316
                         domain_is_shut_down: 317
                                 domain_vcpu: 352
                                 domain_arch: 384
                 schedule_data_schedule_lock: 0
                          schedule_data_curr: 16
                          schedule_data_idle: 0
                    schedule_data_sched_priv: 24
                       schedule_data_s_timer: 32
                          schedule_data_tick: -1
                              scheduler_name: 0
                          scheduler_opt_name: 8
                          scheduler_sched_id: 16
                              scheduler_init: 40
                              scheduler_tick: -1
                         scheduler_init_vcpu: -1
                    scheduler_destroy_domain: 112
                             scheduler_sleep: 136
                              scheduler_wake: 144
                      scheduler_set_affinity: -1
                       scheduler_do_schedule: 168
                            scheduler_adjust: 192
                     scheduler_dump_settings: 216
                    scheduler_dump_cpu_state: 224
                       shared_info_vcpu_info: 0
                  shared_info_evtchn_pending: 2048
                     shared_info_evtchn_mask: 2560
                            shared_info_arch: 3088
                               timer_expires: 0
                                   timer_cpu: 40
                              timer_function: 24
                                  timer_data: 32
                           timer_heap_offset: -1
                                timer_killed: -1
                             tss_struct_rsp0: 4
                             tss_struct_esp0: 0
                                vcpu_vcpu_id: 0
                              vcpu_processor: 4
                              vcpu_vcpu_info: 8
                                 vcpu_domain: 16
                           vcpu_next_in_list: 24
                                  vcpu_timer: -1
                             vcpu_sleep_tick: -1
                             vcpu_poll_timer: 144
                             vcpu_sched_priv: 192
                               vcpu_runstate: 200
                         vcpu_runstate_guest: 248
                             vcpu_vcpu_flags: -1
                            vcpu_pause_count: 296
                         vcpu_virq_to_evtchn: 300
                           vcpu_cpu_affinity: 352
                               vcpu_nmi_addr: -1
                     vcpu_vcpu_dirty_cpumask: 376
                                   vcpu_arch: 640
                    vcpu_runstate_info_state: 0
         vcpu_runstate_info_state_entry_time: 8
                     vcpu_runstate_info_time: 16



After patch 2:



dcs-xen-54:/big/crash/vmcore-hang-0>~/crash-7.0/crash vmcore xen-syms-4.4-unstable

crash 7.0.4
Copyright (C) 2002-2013  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

    KERNEL: xen-syms-4.4-unstable
  DUMPFILE: vmcore
      CPUS: 8
   DOMAINS: 5
    UPTIME: --:--:--
   MACHINE: Intel(R) Xeon(R) CPU E31265L @ 2.40GHz  (2400 Mhz)
    MEMORY: 32 GB
   PCPU-ID: 0
      PCPU: ffff82d0802bff18
   VCPU-ID: 0
      VCPU: ffff8300bf2fe000  (VCPU_RUNNING)
DOMAIN-ID: 32767
    DOMAIN: ffff83083a163000  (DOMAIN_RUNNING)
     STATE: CRASH

crash> doms
    DID       DOMAIN      ST T  MAXPAGE  TOTPAGE VCPU SHARED_I          P2M_MFN
   32753 ffff83083a1a7000 RU O     0        0      0 0              ----
   32754 ffff83083a164000 RU X     0        0      0 0              ----
 >*32767 ffff83083a163000 RU I     0        0      8 0              ----
 >     0 ffff830823fb7000 RU 0 ffffffff   80000    8 ffff8300bf504000      81df80
       2 ffff83083f12e000 RU U  100100    fd043    2 ffff8300bf4b6000         0
crash> help -X ofs
                        ELF_Prstatus_pr_info: 0
                      ELF_Prstatus_pr_cursig: 12
                     ELF_Prstatus_pr_sigpend: 16
                     ELF_Prstatus_pr_sighold: 24
                         ELF_Prstatus_pr_pid: 32
                        ELF_Prstatus_pr_ppid: 36
                        ELF_Prstatus_pr_pgrp: 40
                         ELF_Prstatus_pr_sid: 44
                       ELF_Prstatus_pr_stime: 64
                      ELF_Prstatus_pr_cutime: 80
                      ELF_Prstatus_pr_cstime: 96
                         ELF_Prstatus_pr_reg: 112
                     ELF_Prstatus_pr_fpvalid: 328
                          ELF_Timeval_tv_sec: 0
                         ELF_Timeval_tv_usec: 8
                    arch_shared_info_max_pfn: 0
arch_shared_info_pfn_to_mfn_frame_list_list: 8
                 arch_shared_info_nmi_reason: 16
                cpu_info_guest_cpu_user_regs: 0
                       cpu_info_processor_id: 200
                       cpu_info_current_vcpu: 208
                    cpu_time_local_tsc_stamp: 0
                  cpu_time_stime_local_stamp: 0
                 cpu_time_stime_master_stamp: 0
                          cpu_time_tsc_scale: 0
                  cpu_time_calibration_timer: 0
                           crash_note_t_core: -1
                            crash_note_t_xen: -1
                       crash_note_t_xen_regs: -1
                       crash_note_t_xen_info: -1
                      crash_note_core_t_note: -1
                      crash_note_core_t_desc: -1
                       crash_note_xen_t_note: -1
                       crash_note_xen_t_desc: -1
                  crash_note_xen_core_t_note: -1
                  crash_note_xen_core_t_desc: -1
                  crash_note_xen_info_t_note: -1
                  crash_note_xen_info_t_desc: -1
                            domain_page_list: 0
                         domain_xenpage_list: 0
                            domain_domain_id: 0
                            domain_tot_pages: 56
                            domain_max_pages: 64
                        domain_xenheap_pages: 76
                          domain_shared_info: 8
                           domain_sched_priv: 88
                         domain_next_in_list: 104
                         domain_domain_flags: -1
                               domain_evtchn: 144
                               domain_is_hvm: -1
                        domain_is_privileged: 278
                    domain_debugger_attached: 288
                             domain_is_dying: 292
              domain_is_paused_by_controller: 296
                     domain_is_shutting_down: 316
                         domain_is_shut_down: 317
                                 domain_vcpu: 352
                                 domain_arch: 384
                 schedule_data_schedule_lock: 0
                          schedule_data_curr: 16
                          schedule_data_idle: 0
                    schedule_data_sched_priv: 24
                       schedule_data_s_timer: 32
                          schedule_data_tick: -1
                              scheduler_name: 0
                          scheduler_opt_name: 8
                          scheduler_sched_id: 16
                              scheduler_init: 40
                              scheduler_tick: -1
                         scheduler_init_vcpu: -1
                    scheduler_destroy_domain: 112
                             scheduler_sleep: 136
                              scheduler_wake: 144
                      scheduler_set_affinity: -1
                       scheduler_do_schedule: 168
                            scheduler_adjust: 192
                     scheduler_dump_settings: 216
                    scheduler_dump_cpu_state: 224
                       shared_info_vcpu_info: 0
                  shared_info_evtchn_pending: 2048
                     shared_info_evtchn_mask: 2560
                            shared_info_arch: 3088
                               timer_expires: 0
                                   timer_cpu: 40
                              timer_function: 24
                                  timer_data: 32
                           timer_heap_offset: -1
                                timer_killed: -1
                             tss_struct_rsp0: 4
                             tss_struct_esp0: 0
                                vcpu_vcpu_id: 0
                              vcpu_processor: 4
                              vcpu_vcpu_info: 8
                                 vcpu_domain: 16
                           vcpu_next_in_list: 24
                                  vcpu_timer: -1
                             vcpu_sleep_tick: -1
                             vcpu_poll_timer: 144
                             vcpu_sched_priv: 192
                               vcpu_runstate: 200
                         vcpu_runstate_guest: 248
                             vcpu_vcpu_flags: -1
                            vcpu_pause_count: 296
                         vcpu_virq_to_evtchn: 300
                           vcpu_cpu_affinity: 352
                               vcpu_nmi_addr: -1
                     vcpu_vcpu_dirty_cpumask: 376
                                   vcpu_arch: 640
                    vcpu_runstate_info_state: 0
         vcpu_runstate_info_state_entry_time: 8
                     vcpu_runstate_info_time: 16



After patch 3:


dcs-xen-54:/big/crash/vmcore-hang-0>~/crash-7.0/crash vmcore xen-syms-4.4-unstable

crash 7.0.4
Copyright (C) 2002-2013  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

    KERNEL: xen-syms-4.4-unstable
  DUMPFILE: vmcore
      CPUS: 8
   DOMAINS: 5
    UPTIME: --:--:--
   MACHINE: Intel(R) Xeon(R) CPU E31265L @ 2.40GHz  (2400 Mhz)
    MEMORY: 32 GB
   PCPU-ID: 0
      PCPU: ffff82d0802bff18
   VCPU-ID: 0
      VCPU: ffff8300bf2fe000  (VCPU_RUNNING)
DOMAIN-ID: 32767
    DOMAIN: ffff83083a163000  (DOMAIN_RUNNING)
     STATE: CRASH

crash> doms
    DID       DOMAIN      ST T  MAXPAGE  TOTPAGE VCPU SHARED_I          P2M_MFN
   32753 ffff83083a1a7000 RU O     0        0      0 0              ----
   32754 ffff83083a164000 RU X     0        0      0 0              ----
 >*32767 ffff83083a163000 RU I     0        0      8 0              ----
 >     0 ffff830823fb7000 RU 0 ffffffff   80000    8 ffff8300bf504000      81df80
       2 ffff83083f12e000 CP U  100100    fd043    2 ffff8300bf4b6000         0


After patch 4:


dcs-xen-54:/big/crash/vmcore-hang-0>~/crash-7.0/crash vmcore xen-syms-4.4-unstable

crash 7.0.4
Copyright (C) 2002-2013  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

    KERNEL: xen-syms-4.4-unstable
  DUMPFILE: vmcore
      CPUS: 8
   DOMAINS: 5
    UPTIME: --:--:--
   MACHINE: Intel(R) Xeon(R) CPU E31265L @ 2.40GHz  (2400 Mhz)
    MEMORY: 32 GB
   PCPU-ID: 0
      PCPU: ffff82d0802bff18
   VCPU-ID: 0
      VCPU: ffff8300bf2fe000  (VCPU_RUNNING)
DOMAIN-ID: 32767
    DOMAIN: ffff83083a163000  (DOMAIN_RUNNING)
     STATE: CRASH

crash> doms
    DID       DOMAIN      ST T  MAXPAGE  TOTPAGE VCPU SHARED_I          P2M_MFN
   32753 ffff83083a1a7000 RU O     0        0      0 0              ----
   32754 ffff83083a164000 RU X     0        0      0 0              ----
 >*32767 ffff83083a163000 RU I     0        0      8 0              ----
 >     0 ffff830823fb7000 RU 0 ffffffff   80000    8 ffff8300bf504000      81df80
       2 ffff83083f12e000 CP U  100100    fd043    2 ffff8300bf4b6000         0
crash> help -X ofs
                        ELF_Prstatus_pr_info: 0
                      ELF_Prstatus_pr_cursig: 12
                     ELF_Prstatus_pr_sigpend: 16
                     ELF_Prstatus_pr_sighold: 24
                         ELF_Prstatus_pr_pid: 32
                        ELF_Prstatus_pr_ppid: 36
                        ELF_Prstatus_pr_pgrp: 40
                         ELF_Prstatus_pr_sid: 44
                       ELF_Prstatus_pr_stime: 64
                      ELF_Prstatus_pr_cutime: 80
                      ELF_Prstatus_pr_cstime: 96
                         ELF_Prstatus_pr_reg: 112
                     ELF_Prstatus_pr_fpvalid: 328
                          ELF_Timeval_tv_sec: 0
                         ELF_Timeval_tv_usec: 8
                    arch_shared_info_max_pfn: 0
arch_shared_info_pfn_to_mfn_frame_list_list: 8
                 arch_shared_info_nmi_reason: 16
                cpu_info_guest_cpu_user_regs: 0
                       cpu_info_processor_id: 200
                       cpu_info_current_vcpu: 208
                    cpu_time_local_tsc_stamp: 0
                  cpu_time_stime_local_stamp: 0
                 cpu_time_stime_master_stamp: 0
                          cpu_time_tsc_scale: 0
                  cpu_time_calibration_timer: 0
                           crash_note_t_core: -1
                            crash_note_t_xen: -1
                       crash_note_t_xen_regs: -1
                       crash_note_t_xen_info: -1
                      crash_note_core_t_note: -1
                      crash_note_core_t_desc: -1
                       crash_note_xen_t_note: -1
                       crash_note_xen_t_desc: -1
                  crash_note_xen_core_t_note: -1
                  crash_note_xen_core_t_desc: -1
                  crash_note_xen_info_t_note: -1
                  crash_note_xen_info_t_desc: -1
                            domain_page_list: 0
                         domain_xenpage_list: 0
                            domain_domain_id: 0
                            domain_tot_pages: 56
                            domain_max_pages: 64
                        domain_xenheap_pages: 76
                          domain_shared_info: 8
                           domain_sched_priv: 88
                         domain_next_in_list: 104
                         domain_domain_flags: -1
                               domain_evtchn: 144
                               domain_is_hvm: -1
                           domain_guest_type: 272
                        domain_is_privileged: 278
                    domain_debugger_attached: 288
                             domain_is_dying: 292
              domain_is_paused_by_controller: 296
                     domain_is_shutting_down: 316
                         domain_is_shut_down: 317
                                 domain_vcpu: 352
                                 domain_arch: 384
                 schedule_data_schedule_lock: 0
                          schedule_data_curr: 16
                          schedule_data_idle: 0
                    schedule_data_sched_priv: 24
                       schedule_data_s_timer: 32
                          schedule_data_tick: -1
                              scheduler_name: 0
                          scheduler_opt_name: 8
                          scheduler_sched_id: 16
                              scheduler_init: 40
                              scheduler_tick: -1
                         scheduler_init_vcpu: -1
                    scheduler_destroy_domain: 112
                             scheduler_sleep: 136
                              scheduler_wake: 144
                      scheduler_set_affinity: -1
                       scheduler_do_schedule: 168
                            scheduler_adjust: 192
                     scheduler_dump_settings: 216
                    scheduler_dump_cpu_state: 224
                       shared_info_vcpu_info: 0
                  shared_info_evtchn_pending: 2048
                     shared_info_evtchn_mask: 2560
                            shared_info_arch: 3088
                               timer_expires: 0
                                   timer_cpu: 40
                              timer_function: 24
                                  timer_data: 32
                           timer_heap_offset: -1
                                timer_killed: -1
                             tss_struct_rsp0: 4
                             tss_struct_esp0: 0
                                vcpu_vcpu_id: 0
                              vcpu_processor: 4
                              vcpu_vcpu_info: 8
                                 vcpu_domain: 16
                           vcpu_next_in_list: 24
                                  vcpu_timer: -1
                             vcpu_sleep_tick: -1
                             vcpu_poll_timer: 144
                             vcpu_sched_priv: 192
                               vcpu_runstate: 200
                         vcpu_runstate_guest: 248
                             vcpu_vcpu_flags: -1
                            vcpu_pause_count: 296
                         vcpu_virq_to_evtchn: 300
                           vcpu_cpu_affinity: 352
                               vcpu_nmi_addr: -1
                     vcpu_vcpu_dirty_cpumask: 376
                                   vcpu_arch: 640
                    vcpu_runstate_info_state: 0
         vcpu_runstate_info_state_entry_time: 8
                     vcpu_runstate_info_time: 16


    -Don Slutz


>> Don Slutz (4):
>>    Make domian.is_hvm optional
>>    xen: Fix offset output to be decimal.
>>    xen: set all domain_flags, not just the 1st.
>>    Add basic domain.guest_type support.
>>
>>   xen_hyper.c             | 32 ++++++++++++++++++++++++--------
>>   xen_hyper_defs.h        |  1 +
>>   xen_hyper_dump_tables.c |  4 +++-
>>   3 files changed, 28 insertions(+), 9 deletions(-)
>>
>> --
>> 1.8.4
>>
>> --
>> Crash-utility mailing list
>> Crash-utility@redhat.com
>> https://www.redhat.com/mailman/listinfo/crash-utility
>>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
