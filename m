Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400072.outbound.protection.outlook.com
 ([40.107.140.72] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXgsd-0001Sq-Ma
 for kexec@lists.infradead.org; Wed, 28 Oct 2020 08:32:29 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [MAKDUMPFILE PATCH] Add option to estimate the size of vmcore
 dump files
Date: Wed, 28 Oct 2020 08:32:14 +0000
Message-ID: <OSBPR01MB1991C4EB34CBC812E4616F26DD170@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20201012070905.5837-1-jthierry@redhat.com>
 <CACi5LpNSnr+9v_sMPZnCQu14pML6PR1bBLKqj4tVaxk2O9k0wA@mail.gmail.com>
 <f12bb1e2-c984-68d0-f952-d6b7243c8a7e@redhat.com>
 <CACi5LpM-hCjnFg6Knb57Fr7+zVnTDewYRLAFABeNrd_gy+GhGw@mail.gmail.com>
 <OSBPR01MB19912E6BD4B99FE4915708FFDD030@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <617405cb-717f-62ee-e463-a41dc9560cbb@redhat.com>
In-Reply-To: <617405cb-717f-62ee-e463-a41dc9560cbb@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Julien Thierry <jthierry@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hi Julien,

sorry for my delayed reply.

-----Original Message-----
> >>>>> A user might want to know how much space a vmcore file will take on
> >>>>> the system and how much space on their disk should be available to
> >>>>> save it during a crash.
> >>>>>
> >>>>> The option --vmcore-size does not create the vmcore file but provides
> >>>>> an estimation of the size of the final vmcore file created with the
> >>>>> same make dumpfile options.
> >
> > Interesting.  Do you have any actual use case?  e.g. used by kdumpctl?
> > or use it in kdump initramfs?
> >
> 
> Yes, the idea would be to use this in mkdumprd to have a more accurate
> estimate of the dump size (currently it cannot take compression into
> account and warns about potential lack of space, considering the system
> memory size as a whole).

Hmm, I'm not sure how you are going to implement in mkdumprd, but I do not
recommend that you use it to determine how much disk space should be
allocated for crash dump.  Because, I think that

- It cannot estimate the dump size when a real crash occurs, e.g. if slab
explodes with non-zero data, almost all memory will be captured by makedumpfile
even with -d 31, and compression ratio varies with data in memory.
Also, in most cases, mkdumprd runs at boot time or construction phase
with less memory usage, not at usual application running time.  So it
can underestimate the needed size easily.

- The system might need a full vmcore and need to change makedumpfile's
dump level for an issue in the future.  But many systems cannot change
their disk space allocation easily.  So we should prevent users from
having minimum disk space for crash dump.

So, the following is from mkdumprd on Fedora 32, personally I think this
is good for now.

    if [ $avail -lt $memtotal ]; then
        echo "Warning: There might not be enough space to save a vmcore."
        echo "         The size of $2 should be greater than $memtotal kilo bytes."
    fi

The patch's functionality itself might be useful and I don't reject, though.

> >>>>> @@ -4643,6 +4706,8 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
> >>>>>                   }
> >>>>>                   if (!write_and_check_space(fd, &fdh, sizeof(fdh), file_name))
> >>>>>                           return FALSE;
> >>>>> +       } else if (info->flag_vmcore_size && fd == info->fd_dumpfile) {
> >>>>> +               return write_buffer_update_size_info(offset, buf, buf_size);
> >
> > Why do we need this function?  makedumpfile actually writes zero-filled
> > pages to the dumpfile with -d 0, and doesn't write them with -d 1.
> > So isn't "write_bytes += buf_size" enough?  For example, with -d 30,
> >
> 
> The reason I went with this method was to make an estimate of the number
> of blocks actually allocated on the disk (since depending on how the
> data written is scattered in the file, there might be a significant
> difference between bytes written vs actual size allocated on disk). But
> I realize that there is some misunderstanding from my end since written
> 0 do make block allocation as opposed to not writing at some offset
> (skipping the with lseek() ), I would need to fix that.
> 
> To highlight the behaviour I'm talking about:
> $ dd if=/dev/zero of=./testfile bs=4096 count=1 seek=1
> 1+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000302719 s, 13.5 MB/s
> $ du -h testfile
> 4.0K	testfile
> 
> $ dd if=/dev/zero of=./testfile bs=4096 count=2
> 2+0 records in
> 2+0 records out
> 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.000373002 s, 22.0 MB/s
> $ du -h testfile
> 8.0K	testfile
> 
> 
> So, do you think it's not worth bothering estimating the number of
> blocks allocated an that I should only consider the number of bytes written?

Yes, makedumpfile almost doesn't make empty (sparse) blocks,
so the error would be small enough.

> >>>>
> >>>> I like the idea, but sometimes we use makedumpfile to generate a
> >>>> dumpfile in the primary kernel as well. For example:
> >>>>
> >>>> $ makedumpfile -d 31 -x vmlinux /proc/kcore dumpfile
> >>>>
> >>>> In such use-cases it is useful to use --vmcore-size and still generate
> >>>> the dumpfile (right now the default behaviour is not to generate a
> >>>> dumpfile when --vmcore-size is specified). Maybe we need to think more
> >>>> on supporting this use-case as well.
> >>>>
> >>>
> >>> The thing is, if you are generating the dumpfile, you can just check the
> >>> size of the file created with "du -b" or some other command.
> >>
> >> I agree, but I just was looking to replace the two  'makedumpfile +
> >> du' steps with a single 'makedumpfile --vmcore-size' step.
> >>
> >>> Overall I don't mind supporting your case as well. Maybe that can depend
> >>> on whether a vmcore/dumpfile filename is provided:
> >>>
> >>> $ makedumpfile -d 31 -x vmlinux /proc/kcore    # only estimates the size
> >>>
> >>> $ makedumpfile -d 31 -x vmlinux /proc/kcore dumpfile  # writes the
> >>> dumpfile and gives the final size
> >>>
> >>> Any thought, opinions, suggestions?
> >>
> >> Let's wait for Kazu's opinion on the same, but I am ok with using a
> >> two-step 'makedumpfile + du' approach for now (and later expand
> >> --vmcore-size as we encounter more use-cases).
> >>
> >> @Kazuhito Hagio : What's your opinion on the above?
> >
> > I would prefer only estimating with the option.
> >
> > And if the write_bytes method above is usable, it can be shown also
> > in report messages when wrote the dumpfile.
> >
> 
> Let me know your preferred approach considering my comment above and
> I'll send out a v2.

I'm rethinking about what command options makedumpfile should have.
If once we add an option to makedumpfile, we cannot change it easily,
so I'd like to think carefully.

The calculated size might be useful if it's printed so that it can be
easily post-processed by scripts, e.g. for automated tests.  If so,
makedumpfile already prints its statistics with "--message-level 16",
and it might be useful to also print them by an option like "--show-stats".

  # makedumpfile --show-stats -l -d 31 vmcore dump.ld31
  total_pages xxx
  excluded_pages yyy
  ...
  write_bytes zzz

Also, if we also have "--dry-run" option to not write actually, it's
explicit and meets Bhupesh's use case.  What do you think?

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
