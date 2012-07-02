Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SlfuI-0005WI-9b
 for kexec@lists.infradead.org; Mon, 02 Jul 2012 12:39:12 +0000
Date: Mon, 2 Jul 2012 08:39:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-ID: <20120702123905.GG24929@redhat.com>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
> Hello,
> 
> I improved prototype of cyclic processing as version 2.
> If there is no objection to basic idea, I want to consider the things
> related to performance as next step. (Concretely, buffer size and the patch set
> HATAYAMA-san sent a short time ago.) 
> 

Hi Atushi san,

Good to see this work making progress. I have few queries.

- Do you have some numbers for bigger machines like 1TB or higher memory. 
  I am curious to know how bad is the time penalty.

- Will this work with option -F (flattned format). Often people save
  filtered dump over ssh and we need to make sure it does work with -F
  option too.

> > Version 1:
>  
>   http://lists.infradead.org/pipermail/kexec/2012-May/006363.html

- I have few queries about the diagram in the link above.

- What is 1st cycle, 2nd cycle and 3rd cycle. Are we cycling thorough
  all the pages 3 times for everything?

- What is 1st bitmap and 2nd bitmap and page_header? And why 3 cycles for
  each.

- And why 3 cycles for page_data.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
