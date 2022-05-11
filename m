From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 11 May 2022 18:45:49 +0200
Subject: [PATCH 22/30] panic: Introduce the panic post-reboot notifier list
In-Reply-To: <7017c234-7c73-524a-11b6-fefdd5646f59@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-23-gpiccoli@igalia.com>
 <7017c234-7c73-524a-11b6-fefdd5646f59@igalia.com>
Message-ID: <YnvoPe2cTS31qbjb@osiris>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, May 09, 2022 at 11:16:10AM -0300, Guilherme G. Piccoli wrote:
> On 27/04/2022 19:49, Guilherme G. Piccoli wrote:
> > Currently we have 3 notifier lists in the panic path, which will
> > be wired in a way to allow the notifier callbacks to run in
> > different moments at panic time, in a subsequent patch.
> > 
> > But there is also an odd set of architecture calls hardcoded in
> > the end of panic path, after the restart machinery. They're
> > responsible for late time tunings / events, like enabling a stop
> > button (Sparc) or effectively stopping the machine (s390).
> > 
> > This patch introduces yet another notifier list to offer the
> > architectures a way to add callbacks in such late moment on
> > panic path without the need of ifdefs / hardcoded approaches.
> > 
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Hey S390/SPARC folks, sorry for the ping!
> 
> Any reviews on this V1 would be greatly appreciated, I'm working on V2
> and seeking feedback in the non-reviewed patches.

Sorry, missed that this is quite s390 specific. So, yes, this looks
good to me and nice to see that one of the remaining CONFIG_S390 in
common code will be removed!

For the s390 bits:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

