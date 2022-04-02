From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 2 Apr 2022 17:17:25 +0100
Subject: [PATCH v5 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
In-Reply-To: <YkffO7QHuR2vq3gI@MiWiFi-R3L-srv>
References: <20220402043008.458679-1-bhe@redhat.com>
 <20220402043008.458679-2-bhe@redhat.com>
 <YkffO7QHuR2vq3gI@MiWiFi-R3L-srv>
Message-ID: <Ykh3FVUFQH0x11Zw@casper.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Sat, Apr 02, 2022 at 01:29:31PM +0800, Baoquan He wrote:
> On 04/02/22 at 12:30pm, Baoquan He wrote:
> 
> It's odd. I cann't see the content of patches in this series from my
> mailbox and mail client, but I can see them in lore.kernel.org.

Yes, Red Hat have screwed up their email server again.  David Hildenbrand
already filed a ticket, but you should too so they don't think it's
just him.

https://lore.kernel.org/linux-mm/6696fb21-090c-37c6-77a7-79423cc9c703 at redhat.com/

> https://lore.kernel.org/all/20220402043008.458679-1-bhe at redhat.com/T/#u
> 

