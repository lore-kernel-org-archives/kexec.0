Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RSyak-0000pk-Ns
 for kexec@lists.infradead.org; Tue, 22 Nov 2011 22:13:27 +0000
Date: Tue, 22 Nov 2011 17:13:21 -0500
From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: block: initialize request_queue's numa node during allocation
Message-ID: <20111122221320.GB17543@redhat.com>
References: <4ECB5C80.8080609@redhat.com>
 <alpine.DEB.2.00.1111220140470.4306@chino.kir.corp.google.com>
 <20111122152739.GA5663@redhat.com>
 <20111122211954.GA17120@redhat.com>
 <alpine.DEB.2.00.1111221342320.2621@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111221342320.2621@chino.kir.corp.google.com>
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
To: David Rientjes <rientjes@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Nov 22 2011 at  4:45pm -0500,
David Rientjes <rientjes@google.com> wrote:

> Also, your changelog is inadequate since it doesn't convey that his should 
> be merged for 3.2 because it fixes an oops when there is no node 0!

Also, this isn't new to 3.2, v2 should Cc: stable@kernel.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
