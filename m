Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 20 Apr 2021 13:46:26 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC v2 4/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20210420124626.GB3604224@infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210417001026.23858-5-mcgrof@kernel.org>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Wouldn't it be simpler to just add a new flag to signal a kernel
initiated freeze, or even better the exact reason (suspend) instead of
overloading the state machine?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
