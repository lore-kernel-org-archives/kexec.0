Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNBiK-0003Jh-0b
 for kexec@lists.infradead.org; Tue, 11 Mar 2014 01:42:41 +0000
Date: Mon, 10 Mar 2014 21:42:18 -0400 (EDT)
From: Zhi Zou <zzou@redhat.com>
Message-ID: <1671814704.13309372.1394502138298.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140310211650.GI4352@redhat.com>
References: <1394443511-4243-1-git-send-email-zzou@redhat.com>
 <20140310211650.GI4352@redhat.com>
Subject: Re: [PATCH] vmcore-dmesg stack smashing happend in extreme case
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> On Mon, Mar 10, 2014 at 05:25:11PM +0800, arthur wrote:
> > Description
> > in dump_dmesg_structured() the out_buf size is 4096, and if the
> > length is less than 4080( 4096-16 ) it won't really write out.
> > Normally, after writing one or four chars to the out_buf, it will
> > check the length of out_buf. But in extreme cases, 19 chars was
> > written to the out_buf before checking the length. This may cause
> > the stack corruption. If the length was 4079 (won't realy write out),
> > and then write 19 chars to it. the out_buf will overflow.
> > 
> > Solution
> > Change 16 to 32 and always check the lenth of out_buf before move to
> > next record, thus can make sure that at the beginning of a message
> > we always have 32 bytes of buffer.
> > 
> > Signed-off-by: arthur <zzou@redhat.com>
> > ---
> >  vmcore-dmesg/vmcore-dmesg.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> > index 0345660..0d323c1 100644
> > --- a/vmcore-dmesg/vmcore-dmesg.c
> > +++ b/vmcore-dmesg/vmcore-dmesg.c
> > @@ -674,7 +674,7 @@ static void dump_dmesg_structured(int fd)
> >  			else
> >  				out_buf[len++] = c;
> >  
> > -			if (len >= OUT_BUF_SIZE - 16) {
> > +			if (len >= OUT_BUF_SIZE - 32) {
> 
> How do you know 32 is enough and will not overflow?
> 
> >  				write_to_stdout(out_buf, len);
> >  				len = 0;
> >  			}
> > @@ -682,6 +682,11 @@ static void dump_dmesg_structured(int fd)
> >  
> >  		out_buf[len++] = '\n';
> >  
> > +		if (len >= OUT_BUF_SIZE - 32) {
> > +			write_to_stdout(out_buf, len);
> > +			len = 0;
> > +		}
> 
> Why do we need this? After last check only one extra character "\n"
> has been written?
> 
> I think that this overflow is coming from following sprintf().
> 
>                 len += sprintf(out_buf + len, "[%5llu.%06llu] ",
>                         (long long unsigned int)imaxdiv_sec.quot,
>                         (long long unsigned int)imaxdiv_usec.quot);
> 
> So we are printing 2 long long unsigned int and 3 more chars "[] ". I
> 
> Max long long unsigned int is (2^64 -1) = 18446744073709551615
> 
> Above takes 20 bytes. So total max length can be 20 + 20 + 3 = 43.
> 
> I think just leave 64bytes of buffer before we enter the next message
> and that should be fine.

Hi Vivek
You are right. we need leave 64bytes instead of 32bytes.

> 
> And we don't have to do this twice. Just do it once inside innermost
> for loop.

At the beginning, I think it is unnecessary to do this twice too. But
if the text_len ==0  then the for loop won't be executed and check won't
be executed either. May be this situation never come up, considering it's
cost, I can accept it because most of time we just do the check instead of
write. If it is sure that text_len == 0 never come up, then we should remove
it.

Thanks
zzou

> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
