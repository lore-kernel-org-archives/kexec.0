Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1429289920.5479.8.camel@infradead.org>
Subject: Re: [PATCH RFC 2/6] purgatory: No need to sha256 update if ptr->len
 is zero
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 17 Apr 2015 09:58:40 -0700
In-Reply-To: <a66d1e193a9bd27e940edfbb56ca521556e95b39.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <a66d1e193a9bd27e940edfbb56ca521556e95b39.1429201849.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
> If ptr->len is zero we do not need to update sha256.

Looks OK.  Did you find this sped things up?

Acked-by: Geoff Levand <geoff@infradead.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
