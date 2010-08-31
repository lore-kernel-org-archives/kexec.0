Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OqKce-0006xC-Vd
	for kexec@lists.infradead.org; Tue, 31 Aug 2010 06:47:13 +0000
Date: Tue, 31 Aug 2010 15:35:32 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile failed for 2.6.36-rc2
Message-Id: <20100831153532.29584be8.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <669158817.1613651283230875215.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <820693542.1613251283229007181.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<669158817.1613651283230875215.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: caiqian@redhat.com
Cc: kexec <kexec@lists.infradead.org>


Hi Cai,

Thank you for the report.

I'd like to reproduce the same problem on my machine,
could you please send your kernel .config file ?


Thanks
Ken'ichi Ohmichi

On Tue, 31 Aug 2010 01:01:15 -0400 (EDT)
caiqian@redhat.com wrote:
> Just a head-up,
> 
> # makedumpfile -c -d 31 /proc/vmcore vmcore.c31
> 
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027000, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027000).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027020, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027020).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027040, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027040).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027060, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027060).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027080, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027080).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800270a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800270a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800270c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800270c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800270e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800270e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027100, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027100).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027120, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027120).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027140, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027140).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027160, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027160).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027180, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027180).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800271a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800271a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800271c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800271c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800271e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800271e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027200, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027200).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027220, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027220).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027240, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027240).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027260, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027260).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027280, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027280).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800272a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800272a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800272c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800272c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800272e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800272e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027300, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027300).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027320, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027320).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027340, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027340).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027360, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027360).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027380, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027380).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800273a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800273a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800273c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800273c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800273e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800273e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027400, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027400).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027420, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027420).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027440, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027440).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027460, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027460).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027480, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027480).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800274a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800274a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800274c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800274c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800274e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800274e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027500, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027500).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027520, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027520).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027540, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027540).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027560, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027560).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027580, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027580).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800275a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800275a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800275c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800275c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800275e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800275e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027600, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027600).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027620, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027620).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027640, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027640).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027660, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027660).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027680, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027680).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800276a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800276a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800276c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800276c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800276e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800276e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027700, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027700).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027720, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027720).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027740, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027740).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027760, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027760).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027780, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027780).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800277a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800277a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800277c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800277c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800277e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800277e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027800, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027800).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027820, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027820).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027840, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027840).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027860, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027860).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027880, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027880).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800278a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800278a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800278c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800278c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800278e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800278e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027900, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027900).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027920, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027920).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027940, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027940).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027960, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027960).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027980, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027980).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800279a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800279a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800279c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800279c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8804800279e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8804800279e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027a00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027a00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027a20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027a20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027a40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027a40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027a60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027a60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027a80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027a80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027aa0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027aa0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ac0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ac0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ae0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ae0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027b00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027b00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027b20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027b20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027b40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027b40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027b60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027b60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027b80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027b80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ba0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ba0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027bc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027bc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027be0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027be0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027c00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027c00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027c20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027c20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027c40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027c40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027c60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027c60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027c80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027c80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ca0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ca0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027cc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027cc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ce0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ce0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027d00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027d00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027d20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027d20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027d40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027d40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027d60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027d60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027d80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027d80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027da0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027da0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027dc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027dc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027de0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027de0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027e00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027e00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027e20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027e20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027e40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027e40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027e60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027e60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027e80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027e80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ea0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ea0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ec0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ec0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027ee0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027ee0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027f00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027f00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027f20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027f20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027f40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027f40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027f60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027f60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027f80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027f80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027fa0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027fa0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027fc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027fc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027fe0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880480027fe0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027000, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027000).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027020, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027020).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027040, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027040).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027060, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027060).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027080, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027080).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800270a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800270a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800270c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800270c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800270e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800270e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027100, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027100).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027120, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027120).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027140, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027140).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027160, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027160).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027180, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027180).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800271a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800271a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800271c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800271c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800271e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800271e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027200, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027200).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027220, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027220).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027240, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027240).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027260, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027260).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027280, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027280).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800272a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800272a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800272c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800272c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800272e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800272e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027300, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027300).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027320, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027320).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027340, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027340).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027360, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027360).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027380, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027380).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800273a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800273a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800273c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800273c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800273e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800273e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027400, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027400).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027420, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027420).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027440, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027440).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027460, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027460).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027480, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027480).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800274a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800274a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800274c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800274c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800274e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800274e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027500, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027500).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027520, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027520).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027540, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027540).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027560, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027560).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027580, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027580).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800275a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800275a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800275c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800275c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800275e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800275e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027600, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027600).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027620, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027620).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027640, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027640).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027660, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027660).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027680, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027680).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800276a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800276a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800276c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800276c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800276e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800276e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027700, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027700).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027720, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027720).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027740, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027740).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027760, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027760).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027780, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027780).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800277a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800277a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800277c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800277c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800277e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800277e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027800, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027800).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027820, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027820).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027840, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027840).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027860, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027860).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027880, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027880).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800278a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800278a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800278c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800278c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800278e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800278e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027900, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027900).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027920, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027920).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027940, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027940).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027960, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027960).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027980, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027980).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800279a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800279a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800279c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800279c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff8808800279e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff8808800279e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027a00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027a00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027a20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027a20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027a40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027a40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027a60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027a60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027a80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027a80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027aa0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027aa0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ac0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ac0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ae0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ae0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027b00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027b00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027b20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027b20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027b40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027b40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027b60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027b60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027b80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027b80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ba0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ba0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027bc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027bc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027be0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027be0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027c00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027c00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027c20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027c20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027c40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027c40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027c60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027c60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027c80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027c80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ca0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ca0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027cc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027cc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ce0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ce0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027d00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027d00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027d20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027d20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027d40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027d40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027d60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027d60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027d80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027d80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027da0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027da0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027dc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027dc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027de0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027de0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027e00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027e00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027e20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027e20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027e40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027e40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027e60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027e60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027e80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027e80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ea0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ea0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ec0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ec0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027ee0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027ee0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027f00, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027f00).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027f20, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027f20).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027f40, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027f40).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027f60, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027f60).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027f80, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027f80).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027fa0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027fa0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027fc0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027fc0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880880027fe0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880880027fe0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027000, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027000).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027020, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027020).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027040, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027040).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027060, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027060).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027080, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027080).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c800270a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c800270a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c800270c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c800270c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c800270e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c800270e0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027100, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027100).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027120, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027120).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027140, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027140).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027160, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027160).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c80027180, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c80027180).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c800271a0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c800271a0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c800271c0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c800271c0).
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880c800271e0, size:32
> section_mem_map_addr: Can't get a struct mem_section(ffff880c800271e0).
> Excluding unnecessary pages        : [ 25 %] readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffffea000fb49000, size:4096
> readmem: type_addr: 0, addr:ffffea000fb48000, size:8192
> readmem: type_addr: 0, addr:ffffea000fb47000, size:12288
> readmem: type_addr: 0, addr:ffffea000fb46000, size:16384
> readmem: type_addr: 0, addr:ffffea000fb45000, size:20480
> readmem: type_addr: 0, addr:ffffea000fb44000, size:24576
> readmem: type_addr: 0, addr:ffffea000fb43000, size:28672
> __exclude_unnecessary_pages: Can't read the buffer of struct page.
> create_2nd_bitmap: Can't exclude unnecessary pages.
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
