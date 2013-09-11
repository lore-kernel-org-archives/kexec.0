Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJoJk-0004Pk-3g
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 17:35:04 +0000
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 11 Sep 2013 11:34:41 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7045219D803E
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 11:34:37 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8BHYboL258284
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 11:34:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8BHYb2B010801
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 11:34:37 -0600
Message-ID: <1378920873.2257.353.camel@dhcp-9-2-203-236.watson.ibm.com>
Subject: Re: [PATCH 04/16] integrity: Allow digital signature verification
 with a given keyring ptr
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 13:34:33 -0400
In-Reply-To: <1378849471-10521-5-git-send-email-vgoyal@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-5-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org

On Tue, 2013-09-10 at 17:44 -0400, Vivek Goyal wrote:
> Currently digital signature verification code assumes that it can be
> used only with 3 keyrings. IMA, EVM and MODULE keyring. Provide another
> variant where one can pass in a pointer to keyring (struct key *), and
> integrity code can try to find key in that keyring and verify signature.
> 
> This will be useful at two places.
> 
> - elf binary loader can use system keyring and call into integrity
>   subsystem for signature verification.
> - In later patches I am extending keyctl() to allow signature of
>   a user buffer against specified keyring. That logic can make use
>   of this code too.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

My original thought was to use the system keyring, in lieu of having the
multiple keyrings.  Unfortunately, the scope of a key's usage needs to
be limited, which can not be done safely with a single keyring.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
