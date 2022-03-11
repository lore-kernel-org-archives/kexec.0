From: Philipp Rudo <prudo@redhat.com>
Date: Fri, 11 Mar 2022 13:28:59 +0100
Subject: [PATCH 3/3] makedumpfile: use cycle detection when parsing the
 prink log_buf
In-Reply-To: <TYYPR01MB6777AF73BBD428357DD3E8C5DD0C9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20220307172322.7909-1-prudo@redhat.com>
 <20220307172322.7909-4-prudo@redhat.com>
 <CALF+zOk8oKDXgoNWnDEOgQv99YDbQ0h1OsrpdpOG+rJoXPryBg@mail.gmail.com>
 <20220310153344.2673d45d@rhtmp>
 <TYYPR01MB6777AF73BBD428357DD3E8C5DD0C9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Message-ID: <20220311132859.750c454d@rhtmp>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Kazu,


On Fri, 11 Mar 2022 07:59:47 +0000
HAGIO KAZUHITO(?????) <k-hagio-ab@nec.com> wrote:

> -----Original Message-----
> > Hi Dave,
> > 
> > On Wed, 9 Mar 2022 03:48:12 -0500
> > David Wysochanski <dwysocha@redhat.com> wrote:
> >   
> > > On Mon, Mar 7, 2022 at 12:23 PM Philipp Rudo <prudo@redhat.com> wrote:  
> > > >
> > > > The old printk mechanism (> v3.5.0 and < v5.10.0) had a fixed size
> > > > buffer (log_buf) that contains all messages. The location for the next
> > > > message is stored in log_next_idx. In case the log_buf runs full
> > > > log_next_idx wraps around and starts overwriting old messages at the
> > > > beginning of the buffer. The wraparound is denoted by a message with
> > > > msg->len == 0.
> > > >
> > > > Following the behavior described above blindly in makedumpfile is
> > > > dangerous as e.g. a memory corruption could overwrite (parts of) the
> > > > log_buf. If the corruption adds a message with msg->len == 0 this leads
> > > > to an endless loop when dumping the dmesg with makedumpfile appending
> > > > the messages up to the corruption over and over again to the output file
> > > > until file system is full. Fix this by using cycle detection and aboard
> > > > once one is detected.
> > > >
> > > > While at it also verify that the index is within the log_buf and thus
> > > > guard against corruptions with msg->len != 0.
> > > >
> > > > Fixes: 36c2458 ("[PATCH] --dump-dmesg fix for post 3.5 kernels.")
> > > > Reported-by: Audra Mitchell <aubaker@redhat.com>
> > > > Suggested-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > Signed-off-by: Philipp Rudo <prudo@redhat.com>
> > > > ---
> > > >  makedumpfile.c | 42 ++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 40 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > > index edf128b..2738d16 100644
> > > > --- a/makedumpfile.c
> > > > +++ b/makedumpfile.c
> > > > @@ -15,6 +15,7 @@
> > > >   */
> > > >  #include "makedumpfile.h"
> > > >  #include "print_info.h"
> > > > +#include "detect_cycle.h"
> > > >  #include "dwarf_info.h"
> > > >  #include "elf_info.h"
> > > >  #include "erase_info.h"
> > > > @@ -5528,10 +5529,11 @@ dump_dmesg()
> > > >         unsigned long index, log_buf, log_end;
> > > >         unsigned int log_first_idx, log_next_idx;
> > > >         unsigned long long first_idx_sym;
> > > > +       struct detect_cycle *dc = NULL;
> > > >         unsigned long log_end_2_6_24;
> > > >         unsigned      log_end_2_6_25;
> > > >         char *log_buffer = NULL, *log_ptr = NULL;
> > > > -       char *idx;
> > > > +       char *idx, *next_idx;
> > > >  
> > >
> > > Would be clearer to call the above "next_ptr" rather than "next_idx"
> > > (as far as I know 'index' refers to 32-bit quantities).
> > > Same comment about the "idx" variable, maybe "ptr"?  
> > 
> > Hmm... I stuck with idx as the kernel uses the same name. In my
> > opinion using the same name makes it easier to see that both variables
> > contain the same "quantity" even when the implementation is slightly
> > different (in the kernel idx is the offset in the log_buf just like it
> > was in makedumpfile before patch 2). But my opinion isn't very strong
> > on the naming. So when the consent is to rename the variable I'm open
> > to do it.
> > 
> > @Kazu: Do you have a preference here?  
> 
> Personally I think it will be more readable to use "*ptr" for pointers
> in this case, as Dave says.

ok, then I'll rename it in v2.

Thanks
Philipp


