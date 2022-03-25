From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Fri, 25 Mar 2022 14:04:47 +0100
Subject: running into OOM killer with kexec loading large ramdisk
In-Reply-To: <20220325132611.5b394142@rhtmp>
References: <CAHfPjO8XBp5C_kTaifPjLVJxS3Z7W5V+qHEm6-zh2_Jv8Ydyew@mail.gmail.com>
 <20220325132611.5b394142@rhtmp>
Message-ID: <CAHfPjO97TnqGtN=kZp4M_HGo-2XT7w894Csrw+=JOs600KxBLQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi, thanks for the explanation,
I got it now working, with running the kexec call in the background
and deleting the initramfs in the foreground after sleep 1.
I still think kexec should handle this with less memory needed.
greetings
tpowa

Am Fr., 25. M?rz 2022 um 13:26 Uhr schrieb Philipp Rudo <prudo@redhat.com>:
>
> Hi Tobias,
>
> On Wed, 23 Mar 2022 12:14:59 +0100
> Tobias Powalowski <tobias.powalowski@googlemail.com> wrote:
>
> > Hi,
> > again me,
> > I try to load a 900MB ramdisk on a ramfs rootfs  with kexec and a 10MB kernel.
> > With 2800MB RAM assigned to qemu.
> > Memory free by /proc/memstat: 2.2GB
> > It keeps on OOM killed while executing:
> > kexec -l kernel --initrd=initrd.img
> > I can safely unpack the initrd in the ramfs without getting OOM killed.
> > What is kexec doing wrong here?
>
> I don't think that kexec is doing anything wrong here.
>
> The kexec_load syscall is designed in a way that user space prepares
> everything in a huge buffer and passes a pointer to it to the system
> call. The systemcall then needs to copy everything from the user buffer
> to a kernel buffer. So there are three copies of the initrd in memory
> (including the one in ramfs). Together they take up 3 * 900MB = 2.7GB.
> So basically all the memory of your guest.
>
> You can try using the kexec_file_load systemcall. That at least
> eliminates the copy in the user buffer so there are only two copies
> left. 400MB of free memory is still quite scarce, though.
>
> Thanks
> Philipp
>


-- 
Tobias Powalowski
Arch Linux Developer & Package Maintainer (tpowa)
https://www.archlinux.org
tpowa at archlinux.org

St. Martin-Apotheke
Herzog-Georg-Str. 25
89415 Lauingen
https://www.st-martin-apo.de
info at st-martin-apo.de

