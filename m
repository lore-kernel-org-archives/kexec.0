Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYmEr-0007Yr-6B
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 23:19:21 +0000
Date: Thu, 15 Nov 2012 08:19:18 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH][V2] vmcore-dmesg: Determine correct machine pointer size
Message-ID: <20121114231917.GI15960@verge.net.au>
References: <20121113163827.GB12529@redhat.com> <50A34A83.1030901@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50A34A83.1030901@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 14, 2012 at 03:38:43PM +0800, Dave Young wrote:
> On 11/14/2012 12:38 AM, Vivek Goyal wrote:
> 
> > A 32bit arch can prepare ELF64 headers. For example for PAE case to
> > preresent file offsets 64bit but data size at the offset still remains
> > 32bit. If we just base our decision based on EI_CLASS, then we will try
> > to read 64bit data from file and can run into various issues.
> > 
> > We ran into following issue when we tried to run vmcore-dmesg on a 32bit
> > PAE system vmcore which had 64bit elf headers.
> > 
> > No program header covering vaddr 0xc0a6a688c0b89100found kexec bug?
> > 
> > Basically we try to read value of log_buf variable from address
> > log_buf_vaddr. We read in 64bit value and then pass that value again
> > to vaddr_to_offset() in an attempt to get to actual log_buf start
> > and get error message.
> > 
> > So determine the machine pointer size based on ELF class and arch and read
> > the bytes from file accordingly.
> > 
> > v2: Fixed the code as per suggestion from Eric.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> 
> Ack

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
