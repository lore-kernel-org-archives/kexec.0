Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsSAE-0007X5-Qg
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 07:32:43 +0000
Date: Thu, 5 Jun 2014 15:32:15 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH 0/2] kexec command fails after cpu hot-removing
Message-ID: <20140605073215.GA3876@dhcp-17-89.nay.redhat.com>
References: <1401945055-2820-1-git-send-email-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401945055-2820-1-git-send-email-indou.takao@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 06/05/14 at 02:10pm, Takao Indoh wrote:
> After cpu hot-removing, kexec command fails with the following message.
> 
> "/sys/devices" does not exist. Sysfs does not seem to be mounted. Try
> mounting sysfs.
> 
> Of course sysfs is mounted. kexec tried to open
> /sys/devices/system/cpu/cpu30/crash_notes but it failed because
> /sys/devices/system/cpu/cpu30 did not exist.
> 
> 
> [Before hot-remove]
> 
> # ls /sys/devices/system/cpu/
> cpu0    cpu111  cpu18  cpu31  cpu45  cpu59  cpu72  cpu86  cpuidle
> cpu1    cpu112  cpu19  cpu32  cpu46  cpu6   cpu73  cpu87  intel_pstate
> cpu10   cpu113  cpu2   cpu33  cpu47  cpu60  cpu74  cpu88  kernel_max
> cpu100  cpu114  cpu20  cpu34  cpu48  cpu61  cpu75  cpu89  microcode
> cpu101  cpu115  cpu21  cpu35  cpu49  cpu62  cpu76  cpu9   modalias
> cpu102  cpu116  cpu22  cpu36  cpu5   cpu63  cpu77  cpu90  offline
> cpu103  cpu117  cpu23  cpu37  cpu50  cpu64  cpu78  cpu91  online
> cpu104  cpu118  cpu24  cpu38  cpu51  cpu65  cpu79  cpu92  possible
> cpu105  cpu119  cpu25  cpu39  cpu52  cpu66  cpu8   cpu93  power
> cpu106  cpu12   cpu26  cpu4   cpu53  cpu67  cpu80  cpu94  present
> cpu107  cpu13   cpu27  cpu40  cpu54  cpu68  cpu81  cpu95  probe
> cpu108  cpu14   cpu28  cpu41  cpu55  cpu69  cpu82  cpu96  release
> cpu109  cpu15   cpu29  cpu42  cpu56  cpu7   cpu83  cpu97  uevent
> cpu11   cpu16   cpu3   cpu43  cpu57  cpu70  cpu84  cpu98
> cpu110  cpu17   cpu30  cpu44  cpu58  cpu71  cpu85  cpu99
> 
> 
> [After hot-remove]
> 
> # ls /sys/devices/system/cpu/
> cpu0   cpu16  cpu23  cpu4   cpu65  cpu72  cpu8   cpu87         modalias uevent
> cpu1   cpu17  cpu24  cpu5   cpu66  cpu73  cpu80  cpu88         offline
> cpu10  cpu18  cpu25  cpu6   cpu67  cpu74  cpu81  cpu89         online
> cpu11  cpu19  cpu26  cpu60  cpu68  cpu75  cpu82  cpu9          possible
> cpu12  cpu2   cpu27  cpu61  cpu69  cpu76  cpu83  cpuidle       power
> cpu13  cpu20  cpu28  cpu62  cpu7   cpu77  cpu84  intel_pstate  present
> cpu14  cpu21  cpu29  cpu63  cpu70  cpu78  cpu85  kernel_max    probe
> cpu15  cpu22  cpu3   cpu64  cpu71  cpu79  cpu86  microcode     release
> 
> You can see cpu30 to cpu59, and cpu90 to cpu119 does not exist, they are
> removed from this system by hot-remove operation.
> 
> kexec command expects the number of each directory is contiguous. For
> example, if sysconf(_SC_NPROCESSORS_CONF) is 60, kexec thinks directory
> cpu0, cpu1, cpu2, .... cpu59 exists. But in this case, the number of
> directory is not contiguous. That is the root cause of this problem.
> This patches fix it.
> 
> Takao Indoh (2):
>   Enumerate all /sys/devices/system/cpu/cpuN when they are discontiguous
>   Fix mistaken check of stat(2) return value
> 
>  kexec/crashdump-elf.c | 5 ++++-
>  kexec/crashdump.c     | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)

These two patches look good to me.

Acked-by: WANG Chao <chaowang@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
