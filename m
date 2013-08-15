Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V9sSw-00018D-EO
 for kexec@lists.infradead.org; Thu, 15 Aug 2013 07:59:31 +0000
Date: Thu, 15 Aug 2013 16:56:34 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile-1.5.4 dump dmesg may not work due to
 improper sprintf usage
Message-Id: <20130815165634.258f31248220719535d09e42@mxc.nes.nec.co.jp>
In-Reply-To: <CAPud5_5OhOna27qfXcQbgbx_=PAs=xo5E7=hv207GkPgSmnBCA@mail.gmail.com>
References: <CAPud5_4qP0CRhP_6YzPgV5WeGgcKFg-vyGXa4AUezaPjUxeDsQ@mail.gmail.com>
 <20130806131510.b0c734ed451a6ad109914611@mxc.nes.nec.co.jp>
 <CAPud5_5OhOna27qfXcQbgbx_=PAs=xo5E7=hv207GkPgSmnBCA@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: nick@pistoncloud.com
Cc: nishimura@mxp.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Sorry for late reply.

On Tue, 6 Aug 2013 08:56:56 -0700
Nick Bartos <nick@pistoncloud.com> wrote:

> Yes you are correct on changing DEBUG_MSG to ERRMSG.  I didn't read enough
> of the code to see that was an option.
> 
> Each buffer size check does something specific, which was intended to
> handle all failure cases.  While it's probably possible to do the same
> checks in less actual code, simply removing any of the checks will make it
> fail in some cases.  Also, if someone sets BUFSIZE to a very small number
> when nothing will work, it makes sense to exit with failure without trying
> to read anything.  However if only a few lines are going to be truncated
> because they are too long, it makes sense to continue on and get as much
> debug output as possible (but with printing the error message about
> truncation).

I also think it's good to output messages as much as possible even if they
are truncated.

Now, I hit upon another idea. How about dividing the read and write processing
in multiple parts like below? This way can treat any length message with
fixed BUFSIZE without truncation.


message      [  112.919861] sd 2:1:2:0: [sdf] Unhandled error code\n\0

             |---- BUFSIZE -----|---- BUFSIZE -----|---- BUFSIZE -----|
read/write            1                  2                  3
times     


If that is OK with you, could you post your v2 patch ?


Thanks
Atsushi Kumagai
 
> Good catch on using a null character, that makes more sense as the former
> would likely result in a compiler warning.
> 
> 
> On Mon, Aug 5, 2013 at 9:15 PM, Atsushi Kumagai <
> kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> 
> > Hello Nick,
> >
> > On Mon, 29 Jul 2013 09:27:57 -0700
> > Nick Bartos <nick@pistoncloud.com> wrote:
> >
> > > I am reporting this bug as requested in the "BUG REPORT" of
> > > the makedumpfile README.
> > >
> > > There are several times when sprintf is used to append to a buffer like
> > so:
> > > sprintf(buf, "%s.", buf);
> > >
> > > In the sprintf manpage, it describes that behavior is not consistent.  I
> > > first noticed this as my hardned system would make all dmesg output lines
> > > empty.  Here is the excerpt from the man page:
> > >
> > >     C99 and POSIX.1-2001 specify that the results  are  undefined if a
> > call
> > > to sprintf(), snprintf(),  vsprintf(),  or vsnprintf() would cause
> > copying
> > > to take place between objects that overlap (e.g., if the target string
> > > array and one of the supplied input  arguments refer to the same buffer).
> > >  See NOTES.
> > >
> > > NOTES
> > >        Some programs imprudently rely on code such as the following
> > >
> > >            sprintf(buf, "%s some further text", buf);
> > >
> > >        to  append text to buf.  However, the standards explicitly note
> > that
> > > the results are undefined if source and  destination  buffers  overlap
> > >  when  calling  sprintf(),  snprintf(), vsprintf(),  and  vsnprintf().
> > > Depending on the version of gcc(1) used, and the compiler options
> > employed,
> > > calls such as the above will not produce the expected results.
> > >
> > >        The glibc implementation of the functions snprintf() and
> > vsnprintf()
> > > conforms to  the  C99 standard, that is, behaves as described above,
> > since
> > > glibc version 2.1.  Until glibc 2.0.6 they would return -1 when the
> > output
> > > was truncated.
> > >
> > >
> > > In addition to using sprintf improperly, it appears that there may be
> > > buffer overflow potential in the current code, since the loop does not
> > stop
> > > if the size of buf is exhausted.
> > >
> > > I have attached a patch which modifies this behavior.
> >
> > I have some comments on this patch, please see below.
> >
> > > diff -U3 -r makedumpfile-1.5.4.orig/makedumpfile.c
> > makedumpfile-1.5.4/makedumpfile.c
> > > --- makedumpfile-1.5.4.orig/makedumpfile.c    2013-07-01
> > 08:08:49.000000000 +0000
> > > +++ makedumpfile-1.5.4/makedumpfile.c 2013-07-22 22:47:34.195721706 +0000
> > > @@ -3701,6 +3701,7 @@
> > >       char *msg, *p;
> > >       unsigned int i, text_len;
> > >       unsigned long long ts_nsec;
> > > +     int buf_s;
> > >       char buf[BUFSIZE];
> > >       ulonglong nanos;
> > >       ulong rem;
> > > @@ -3713,21 +3714,49 @@
> > >
> > >       msg = logptr + SIZE(log);
> > >
> > > -     sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> > > +     buf_s = snprintf(buf, BUFSIZE, "[%5lld.%06ld] ", nanos, rem/1000);
> > > +     if (buf_s < 0) {
> > > +             DEBUG_MSG("snprintf returned an error in
> > dump_log_entry.\n");
> > > +             return FALSE;
> > > +     }
> >
> > This is the error case, so you should use ERRMSG instead of DEBUG_MSG.
> > The same can be said about all other messages.
> >
> > > +     if (buf_s >= BUFSIZE) {
> > > +             DEBUG_MSG("snprintf truncated output in
> > dump_log_entry.\n");
> > > +             DEBUG_MSG("  increase BUFSIZE and recompile.\n");
> > > +             /* No point in continuing, we can't append anything useful
> > */
> > > +             return FALSE;
> > > +     }
> > > +
> > > +     /* It's unlikely but possible we may not have enough to terminate
> > the
> > > +        string */
> > > +     if (buf_s >= BUFSIZE - 1) {
> > > +             DEBUG_MSG("not enough buffer space in dump_log_entry.\n");
> > > +             DEBUG_MSG("  increase BUFSIZE and recompile.\n");
> > > +             return FALSE;
> > > +     }
> > > +
> > > +     for (i = 0, p = msg; i < text_len; i++, p++, buf_s++) {
> > > +             if (buf_s >= BUFSIZE - 2) {
> > > +                     DEBUG_MSG("output truncated in dump_log_entry.\n");
> > > +                     DEBUG_MSG("  increase BUFSIZE and recompile.\n");
> > > +                     break;
> > > +             }
> >
> > I don't think to check the remaining buffer space 3 times is meaningful,
> > they indicate just "lack of buffer space".
> > Is the last one enough to check the remaining buffer space ?
> >
> > >
> > > -     for (i = 0, p = msg; i < text_len; i++, p++) {
> > >               if (*p == '\n')
> > > -                     sprintf(buf, "%s.", buf);
> > > +                     buf[buf_s] = '.';
> > >               else if (isprint(*p) || isspace(*p))
> > > -                     sprintf(buf, "%s%c", buf, *p);
> > > +                     buf[buf_s] = *p;
> > >               else
> > > -                     sprintf(buf, "%s.", buf);
> > > +                     buf[buf_s] = '.';
> > >       }
> > >
> > > -     sprintf(buf, "%s\n", buf);
> > > +     buf[buf_s] = '\n';
> > > +     buf_s++;
> > > +     buf[buf_s] = NULL;
> >
> > Null character(\0) should be used to terminate strings instead of
> > null pointer.
> >
> > >
> > > -     if (write(info->fd_dumpfile, buf, strlen(buf)) < 0)
> > > +     if (write(info->fd_dumpfile, buf, strlen(buf)) < 0) {
> > > +             DEBUG_MSG("Problem writing to dump file.\n");
> > >               return FALSE;
> > > +        }
> > >       else
> > >               return TRUE;
> > >  }
> >
> >
> > Thanks
> > Atsushi Kumagai
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
